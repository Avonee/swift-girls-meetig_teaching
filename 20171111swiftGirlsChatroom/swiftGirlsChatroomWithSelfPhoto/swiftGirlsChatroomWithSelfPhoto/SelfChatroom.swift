//
//  SelfChatroom.swift
//  swiftGirlsChatroomWithSelfPhoto
//
//  Created by 鄭雅方 on 2017/11/5.
//  Copyright © 2017年 鄭雅方. All rights reserved.
//

import UIKit
import Firebase

class SelfChatroom: UIViewController, UITextFieldDelegate {
    
    // 宣告UI元件
    @IBOutlet var dialogShow: UITextView!
    @IBOutlet var saidInput: UITextField!
    
    // 調整textField 位置時需要constraint
    @IBOutlet var saidTextFieldBottomConstraint: NSLayoutConstraint!
    
    // 使用Firebase Database需建立的參考（告訴app database在哪）
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設定textField 的delegate
        saidInput.delegate = self
        
        // 建立ref
        ref = Database.database().reference()
        
        _ = ref.observe(.childAdded, with: { (snapshot: DataSnapshot) in
            if snapshot.value != nil {
                let dict = snapshot.value! as! NSDictionary
                let name = dict["name"] as! String
                let said = dict["said"] as! String
                
                self.dialogShow.text = self.dialogShow.text + "\(name): \(said)\n"
            }
        })
        
        // 監聽鍵盤出現及消失，來調整TextField 位置
        NotificationCenter.default.addObserver(self, selector: #selector(SelfChatroom.adjustTextFieldByKeyboard(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SelfChatroom.adjustTextFieldByKeyboard(notification:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Clicked
    // 按下Send 按鈕後觸發的方法，將textField 中的文字上傳至database
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        // 建立一個儲存這筆資料的id
        let key = self.ref.childByAutoId().key
        // 將所需的資料（id, name, said）存成dictionary
        let value = ["id" : "avon", "name" : "Avon", "said" : saidInput.text!]
        
        let childUpdate = ["\(key)": value]
        
        // 上傳資料至database
        ref.updateChildValues(childUpdate)
        
        // 刪除textField 中的文字
        saidInput.text = nil
        // 收鍵盤
        saidInput.resignFirstResponder()
    }
    
    //MARK: TextField Delegate
    // 鍵盤按下Return 後觸發的方法
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 收鍵盤
        textField.resignFirstResponder()
        
        return true
    }
    
    //MARK: NotificationCenter Methods
    func adjustTextFieldByKeyboard(notification: Notification) {
        // 判斷鍵盤出現或收合
        if notification.name == .UIKeyboardWillShow {
            // 取得鍵盤高度
            let userInfo = notification.userInfo
            let keyboardHeight = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size.height
            // 調整textField 的位置至鍵盤上方
            saidTextFieldBottomConstraint.constant += keyboardHeight
        } else if notification.name == .UIKeyboardWillHide {
            // 調整textField 的位置至預設位置
            saidTextFieldBottomConstraint.constant = 10
        }
    }

}
