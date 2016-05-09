//
//  View3Controller.swift
//  teach1
//
//  Created by rubl333 on 2016/5/7.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit

class View3Controller: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        let address = "https://www.google.com/"
        let url = NSURL(string: address)
        let request = NSURLRequest(URL: url!)
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
