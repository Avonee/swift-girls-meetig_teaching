//
//  ViewController.swift
//  gif_teach
//
//  Created by rubl333 on 2016/6/14.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //宣告動畫Image
    @IBOutlet weak var gif_image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //設置圖片矩陣
        var imageArray:[UIImage] = []

        //for-in loop 把全部圖片放到array內
        for j in 3...8{
           
           imageArray.append(UIImage(named:"computer_superman_0\(j)_gif")! )
            
        }
        
        //動畫Image的動畫圖片是圖片矩陣
        gif_image.animationImages = imageArray
        //動畫Image的動畫時長
        gif_image.animationDuration = 0.5
        //動畫Image開始
        gif_image.startAnimating()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

