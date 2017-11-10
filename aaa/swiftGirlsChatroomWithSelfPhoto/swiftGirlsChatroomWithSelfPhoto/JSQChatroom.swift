//
//  JSQChatroom.swift
//  swiftGirlsChatroomWithSelfPhoto
//
//  Created by 鄭雅方 on 2017/11/5.
//  Copyright © 2017年 鄭雅方. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class JSQChatroom: JSQMessagesViewController {
    
    // 使用Firebase Database, Storage, 需建立的參考（告訴app database在哪）
    var ref: DatabaseReference!
//    var storageRef: StorageReference!
    
    // 用來儲存對話訊息
    var messages = [JSQMessage]()
    // 對方和自己的大頭貼
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    // 用來儲存下載下來的照片，作為自己的大頭貼
    var selfImage: UIImage? 

    override func viewDidLoad() {
        super.viewDidLoad()

        // 建立ref & storageRef
        ref = Database.database().reference()
//        storageRef = Storage.storage().reference()
        
        // 告訴JSQ 套件，目前是這隻app的用戶是誰
        senderDisplayName = "Avon"
        senderId = "avon"
        
        // 設定對話泡泡
        setupBubbles()
        
        // 下載Firebase上的圖片
//        downloadImage()
        
        // 告訴ref，database 如果有新增的資料時要做的事
        _ = ref.observe(.childAdded, with: { (snapshot: DataSnapshot) in
            // snapshot 是目前取得的狀態，如果snapshot 有值才需繼續做
            if snapshot.value != nil {
                // 抓出snapshot 中我們需要的資料
                let dict = snapshot.value! as! NSDictionary
                let uid = dict["id"] as! String
                let name = dict["name"] as! String
                let said = dict["said"] as! String
                
                // 將snapshot 抓出的資料轉換成JSQ 可使用的JSQMessage，並存進messages 裡
                let messageObj = JSQMessage(senderId: uid, displayName: name, text: said)
                self.messages.append(messageObj!)
            }
            
            // 切到主執行緒，讓collectionView 更新資料，並滑到最底下的訊息處
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.scrollToBottom(animated: true)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Button Clicked
    // 覆寫JSQMessagesViewController 中的didPressSend()，按下Send 後觸發的方法，與我們自己拉的UI 做一樣的事
    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        /**
         *  Sending a message. Your implementation of this method should do *at least* the following:
         *
         *  1. Play sound (optional)
         *  2. Add new id<JSQMessageData> object to your data source
         *  3. Call `finishSendingMessage`
         */
        let key = self.ref.childByAutoId().key
        let value = ["id" : "avon", "name" : "Avon", "said" : text]
        
        let childUpdate = ["\(key)": value]
        
        ref.updateChildValues(childUpdate)
        
        // 告訴JSQ 我們已經傳送資料完成，幫我們把textField 清空
        self.finishSendingMessage(animated: true)
    }
    
    //MARK: Private Method
    // 設定對話泡泡
    private func setupBubbles() {
        // 將傳進來的訊息泡泡背景設為灰色
        incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImage(with: UIColor.lightGray)
        
        // 將傳進來的訊息泡泡背景設為藍色
        outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    // 設定大頭貼
    private func getAvatar(name: String) -> JSQMessagesAvatarImage! {
        if name == self.senderDisplayName && selfImage != nil {
            return JSQMessagesAvatarImageFactory.avatarImage(with: selfImage, diameter: 30)
        } else {
            // 抓取傳訊者名字的第一個字，並改成大寫
             let firstChar = String(name.first!).uppercased()
//            let firstChar = String(name.characters.first!).uppercased()
            
            return JSQMessagesAvatarImageFactory.avatarImage(withUserInitials: firstChar, backgroundColor: UIColor.jsq_messageBubbleGreen(), textColor: UIColor.white, font: UIFont.systemFont(ofSize: 12), diameter: 30)
        }
    }
    
    /*
    // 下載圖片當作自己的大頭貼
    func downloadImage() {
        let imageRef = storageRef.child("傑尼龜2.png")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print("error: \(error)")
            } else {
                // Data for "images/island.jpg" is returned
                self.selfImage = UIImage(data: data!)
                
            }
        }
    }
 */
    
    //MARK: JSQMessages CollectionView DataSource
    // 設定collectionView 的數量
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    // 設定JSQ 所需要的JSQMessageData
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        return messages[indexPath.item]
    }
    
    // 設定對話泡泡
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource {
        return messages[indexPath.item].senderId == self.senderId ? outgoingBubble : incomingBubble
    }
    
    // 設定大頭貼
    override func collectionView(_ collectionView: JSQMessagesCollectionView, avatarImageDataForItemAt indexPath: IndexPath) -> JSQMessageAvatarImageDataSource? {
        let message = messages[indexPath.item]
        return getAvatar(name: message.senderDisplayName)
    }
    
    // 設定傳訊者的名字
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath) -> NSAttributedString? {
        let message = messages[indexPath.item]
        
        // 如果訊息是自己發出去的，就不顯示名字
        if message.senderId == self.senderId {
            return nil
        }
        
        return NSAttributedString(string: message.senderDisplayName)
    }
    
    // 設定顯示傳訊者的名字的label 的高度
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAt indexPath: IndexPath) -> CGFloat {
        
        let currentMessage = self.messages[indexPath.item]
        
        // 如果訊息是自己發出去的，則高度為0
        if currentMessage.senderId == self.senderId {
            return 0.0
        }
        
        // 如果目前的訊息和前一封訊息是同一人所發的，則高度為0
        if indexPath.item - 1 >= 0 {
            let previousMessage = self.messages[indexPath.item - 1]
            if previousMessage.senderId == currentMessage.senderId {
                return 0.0
            }
        }
        
        return kJSQMessagesCollectionViewCellLabelHeightDefault;
    }

}
