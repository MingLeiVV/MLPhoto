//
//  ViewController.swift
//  test
//
//  Created by 吴明磊 on 15/8/8.
//  Copyright © 2015年 wuminglei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }



    @IBAction func click(sender: AnyObject) {
        
        presentViewController(MLPhotoChooseController(), animated: true, completion: nil)
    }
}

