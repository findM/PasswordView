//
//  ViewController.swift
//  SampleDemo
//
//  Created by 陈光临 on 15/11/30.
//  Copyright © 2015年 cn.chenguanglin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = SetPassWordView(frame: CGRect(x: 10, y: 100, width: 200, height: 40))
        //完成输入的回调
        v.doneAction = {(text) -> () in
            print(text)
            //to do something
        }
        self.view.addSubview(v)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

