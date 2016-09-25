//
//  StartViewController.swift
//  testChatRoom
//
//  Created by rubl333 on 2016/9/25.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var nameInput: UITextField!
    
    
    @IBOutlet weak var goButton: UIButton!
    
    
    @IBAction func goClick(sender: AnyObject) {
        
        self.performSegueWithIdentifier("next", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ViewController
        vc.nameGet = self.nameInput.text!
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
