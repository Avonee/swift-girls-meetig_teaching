//
//  ViewController.swift
//  testTablevIEW
//
//  Created by rubl333 on 2016/8/15.
//  Copyright © 2016年 appcoda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //宣告一個變數來儲存表格資料
    var pokemon = ["Horsea","Golden","Eevee","皮卡丘","妙蛙種子","長頸鹿","無尾熊", "貓頭鷹", "狼人", "猩球崛起", "老鷹","獅子", "老虎","天鵝","后里蟹"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //要幾列
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    
    
    //指定cell,並告知要放什麼內容
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        //指定要哪個特定cell
        let cellID = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as UITableViewCell
        
        //cell內的文字內容是...
        cell.textLabel!.text = pokemon[indexPath.row]
        
        //cell內新增圖片
        cell.imageView!.image = UIImage(named:"animal")
        
        return cell
    }


}

