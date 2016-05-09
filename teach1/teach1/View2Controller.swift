//
//  View2Controller.swift
//  teach1
//
//  Created by rubl333 on 2016/5/6.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit

class View2Controller: UIViewController {

    @IBOutlet weak var name_get: UILabel!
    var text = ""
    @IBOutlet weak var head: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    name_get.text = text
        
        self.head.layer.cornerRadius = self.head.frame.size.width/2
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
