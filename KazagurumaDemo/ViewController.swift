//
//  ViewController.swift
//  KazagurumaDemo
//
//  Created by nakajijapan on 2015/12/30.
//  Copyright (c) 2015 nakajijapan. All rights reserved.
//

import Foundation
import UIKit
import Kazaguruma

class ViewController: UIViewController {



    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerView2: UIView!
    @IBOutlet weak var contentView: UIView!

    var items = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = Kazaguruma.show(self.headerView)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            Kazaguruma.hide(self.headerView)
        }

        _ = Kazaguruma.show(self.headerView2, backgroundColor: .black , indicatorViewStyle: .whiteLarge)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            Kazaguruma.hide(self.headerView2)
        }

        _ = Kazaguruma.show(self.contentView, backgroundColor: .white, indicatorViewStyle: .gray, message: "Sorry, wait...", afterdelay: 4.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 7.0) {
            Kazaguruma.hide(self.contentView, animated: true, completion: { () -> Void in
                print("close!")
            })
        }
    }
}

