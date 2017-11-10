//
//  ViewController.swift
//  swiftGirlsChatroomWithSelfPhoto
//
//  Created by 鄭雅方 on 2017/10/18.
//  Copyright © 2017年 鄭雅方. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //UIImagePickerController繼承自UINavigationController, 所以它的delegate需要實現UIImagePickerControllerDelegate和UINavigationControllerDelegate兩個協議.
    
    @IBOutlet weak var BigHead: UIImageView!
    var imagePicker:UIImagePickerController!
    
    
    var whitchtype = 0
    @IBAction func getPictureClick(_ sender: Any) {
        whitchtype = 0
        imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = .currentContext
        
        //指定數據來源
        imagePicker.sourceType = .photoLibrary
//            .savedPhotosAlbum //所有照片 ex: Moments
//            .camera //直接開相機
//            .photoLibrary//所有相簿 or 內建相簿資料庫 (Default) ex: Photos
        
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func takePictureClick(_ sender: Any) {
        
        whitchtype = 1
        imagePicker = UIImagePickerController()
        imagePicker.modalTransitionStyle = .flipHorizontal
        imagePicker.allowsEditing = true//是否允許编辑
        imagePicker.sourceType = .camera//從手機相機讀取
        imagePicker.videoMaximumDuration = 15      //錄製長度，秒
        imagePicker.mediaTypes = ["public.image"]        //相机类型(拍照,錄影....)
        imagePicker.videoQuality = .typeHigh    //視頻質量
        imagePicker.cameraCaptureMode = .photo//初始模式; 另有 .video
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
    // MARK: UIImagePickerControllerDelegate實作
    //拿相片頁面
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if whitchtype == 0{
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
                BigHead.image = image
            }
            
            imagePicker.dismiss(animated: true, completion: nil)
        }else{
            //獲取媒體的類型
            let mediaType = info[UIImagePickerControllerMediaType] as! String
            
            //如果媒體是照片
            if mediaType == kUTTypeImage as String {
                //獲取到拍摄的照片, UIImagePickerControllerEditedImage是經過剪裁過的照片,UIImagePickerControllerOriginalImage是原始的照片
                let image = info[UIImagePickerControllerEditedImage] as! UIImage
                BigHead.image = image
                //調用方法保存到圖像庫中
                UIImageWriteToSavedPhotosAlbum(image, self,#selector(ViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
                
            }
            
            //關掉相機畫面
            imagePicker.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    // 照片保存後呼叫此function
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "成功保存照片到圖庫", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! JSQChatroom
            vc.selfImage = self.BigHead.image
    }
    
    
    
    
}

