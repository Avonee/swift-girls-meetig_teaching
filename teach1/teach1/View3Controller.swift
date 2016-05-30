//
//  View3Controller.swift
//  teach1
//
//  Created by rubl333 on 2016/5/7.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit

class View3Controller: UIViewController {

    //宣告 web view
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //網址為...
        let address = "https://www.google.com/"
        
        //網址轉成url型態
        let url = NSURL(string: address)
        
        //請求使用url
        let request = NSURLRequest(URL: url!)
        
        //webview的載入請求
        self.webView.loadRequest(request)
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
