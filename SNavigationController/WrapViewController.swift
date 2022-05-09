//
//  Copyright © 2019 ZhiweiSun. All rights reserved.
//
//  File name: WrapViewController.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2019/6/12: Created by szwathub on 2019/6/12
//

import UIKit

var s_tabBarRectValue: NSValue?

class WrapViewController: UIViewController {

    public var rootViewController: UIViewController? {
        if let wrapNavController = children.first as? WrapNavigationController {
            return wrapNavController.topViewController
        }

        return nil
    }

    public override var fullScreenPopGestureEnabled: Bool {
        get {
            if let fullScreenPopGestureEnabled = rootViewController?.fullScreenPopGestureEnabled {
                return fullScreenPopGestureEnabled
            }

            return false
        }
        set {
            super.fullScreenPopGestureEnabled = newValue
        }
    }

    public override var hidesBottomBarWhenPushed: Bool {
        get {
            if let hidesBottomBarWhenPushed = rootViewController?.hidesBottomBarWhenPushed {
                return hidesBottomBarWhenPushed
            }

            return false
        }
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
    }

    public override var tabBarItem: UITabBarItem? {
        get {
            if let tabBarItem = rootViewController?.tabBarItem {
                return tabBarItem
            }

            return nil
        }
        set {
            super.tabBarItem = newValue
        }
    }

    public override var title: String? {
        get {
            return rootViewController?.title
        }
        set {
            super.title = newValue
        }
    }

    public override var childForStatusBarStyle: UIViewController? {
        return rootViewController
    }

    public override var childForStatusBarHidden: UIViewController? {
        return rootViewController
    }

    class func wrapViewController(_ viewController: UIViewController) -> WrapViewController {
        let wrapNavController = WrapNavigationController()
        wrapNavController.viewControllers = [viewController]

        let wrapViewController = WrapViewController()
        wrapViewController.view.addSubview(wrapNavController.view)
        wrapViewController.addChild(wrapNavController)

        viewController.wrapViewController = wrapViewController

        return wrapViewController
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let barController = tabBarController else {
            return
        }

        if s_tabBarRectValue == nil {
            s_tabBarRectValue = NSValue.init(cgRect: barController.tabBar.frame)
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let tabBarController = tabBarController, let rootController = rootViewController else {
            return
        }

        if rootController.hidesBottomBarWhenPushed {
            tabBarController.tabBar.frame = CGRect.zero
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let tabBarController = tabBarController, let rectValue = s_tabBarRectValue else {
            return
        }

        tabBarController.tabBar.isTranslucent = true
        if !tabBarController.tabBar.isHidden {
            tabBarController.tabBar.frame = rectValue.cgRectValue
        }
    }
}
