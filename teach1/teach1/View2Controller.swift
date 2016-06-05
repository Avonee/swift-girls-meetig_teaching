//
//  View2Controller.swift
//  teach1
//
//  Created by rubl333 on 2016/5/6.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit

class View2Controller: UIViewController {

    //文字顯示欄
    @IBOutlet weak var name_get: UILabel!
    
    
    //圖片視圖
    @IBOutlet weak var head: UIImageView!
    
    
    //定義 第二頁接收的是文字
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //文字顯示欄裡的文字 ＝ 第二頁接收的文字
        name_get.text = name
        
        //圖片的遮罩之圓角弧度半徑 是 圖片本身寬度的1/2
        self.head.layer.cornerRadius = self.head.frame.size.width/2
        
        //圖片的遮罩是否要放上去？ 
        self.head.layer.masksToBounds = true
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
