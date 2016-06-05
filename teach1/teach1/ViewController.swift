//
//  ViewController.swift
//  teach1
//
//  Created by rubl333 on 2016/5/6.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //放文字的欄框
    @IBOutlet weak var nameInput: UITextField!
    
    //按鈕
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //segue 的 function
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //定義要換頁到哪裡？
        //segue的目標（destinationViewController）是 (as!) 第二頁（View2Controller）
            let seconed = segue.destinationViewController as! View2Controller
        
        //第二頁的文字 = 第一頁 放文字籃框裡的文字
            seconed.name = self.nameInput.text!
            
      
        
    }
}

