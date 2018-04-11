//
//  ViewController2.swift
//  KazagurumaDemo
//
//  Created by Daichi Nakajima on 2018/04/11.
//  Copyright © 2018 nakajijapan. All rights reserved.
//

import UIKit
import Kazaguruma

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = Kazaguruma.show(view, backgroundColor: UIColor(red: 0, green: 0, blue: 1.0, alpha: 0.8), indicatorViewStyle: .whiteLarge)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            Kazaguruma.hide(self.view, animated: true, completion: {
                print("finished")
            })
        }

    }
}
