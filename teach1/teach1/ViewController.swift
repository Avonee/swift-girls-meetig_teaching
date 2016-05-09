//
//  ViewController.swift
//  teach1
//
//  Created by rubl333 on 2016/5/6.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameInput: UITextField!
    
    @IBAction func nextButton(sender: AnyObject) {
        
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            let seconed = segue.destinationViewController as! View2Controller
            seconed.text = self.nameInput.text!
            
        
        
    
        
    }
}

