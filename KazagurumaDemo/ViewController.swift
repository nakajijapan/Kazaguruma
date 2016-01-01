//
//  ViewController.swift
//  KazagurumaDemo
//
//  Created by nakajijapan on 2015/12/30.
//  Copyright (c) 2015 nakajijapan. All rights reserved.
//

import UIKit
import Kazaguruma

class ViewController: UIViewController {



    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerView2: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Kazaguruma.show(self.headerView)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            Kazaguruma.hide(self.headerView)
        })

        Kazaguruma.show(self.headerView2, backgroundColor: UIColor.blackColor() , indicatorViewStyle: .WhiteLarge)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(5.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            Kazaguruma.hide(self.headerView2)
        })
        
        Kazaguruma.show(self.contentView, backgroundColor: UIColor.whiteColor(), indicatorViewStyle: .Gray, message: "Sorry, wait...", afterdelay: 4.0)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(7.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            Kazaguruma.hide(self.contentView, animated: true, completion: { () -> Void in
                print("close!")
            })
            
        })

        
    }
    
}

