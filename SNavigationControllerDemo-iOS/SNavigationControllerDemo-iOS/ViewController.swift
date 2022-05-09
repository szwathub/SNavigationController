//
//  Copyright © 2019 ZhiweiSun. All rights reserved.
//
//  File name: ViewController.swift
//  Author:    ZhiweiSun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      06/12/2019: Created by szwathub on 06/12/2019
//

import UIKit
import SNavigationController

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(showController))
        view.addGestureRecognizer(tap)
    }

    @objc func showController() {
        let controller = UIViewController()
        controller.fullScreenPopGestureEnabled = true
        controller.view.backgroundColor = .red
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
