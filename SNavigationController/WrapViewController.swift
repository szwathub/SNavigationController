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

final class WrapViewController: UIViewController {
    var rootViewController: UIViewController? {
        if let wrapNavController = children.first as? WrapNavigationController {
            return wrapNavController.topViewController
        }

        return nil
    }

    override var s_fullScreenPopGestureEnabled: Bool {
        set {
            super.s_fullScreenPopGestureEnabled = newValue
        }
        get {
            if let fullScreenPopGestureEnabled = rootViewController?.s_fullScreenPopGestureEnabled {
                return fullScreenPopGestureEnabled
            }

            return false
        }
    }

    override var hidesBottomBarWhenPushed: Bool {
        set {
            super.hidesBottomBarWhenPushed = newValue
        }
        get {
            if let hidesBottomBarWhenPushed = rootViewController?.hidesBottomBarWhenPushed {
                return hidesBottomBarWhenPushed
            }

            return false
        }
    }

    override var tabBarItem: UITabBarItem? {
        set {
            super.tabBarItem = newValue
        }
        get {
            if let tabBarItem = rootViewController?.tabBarItem {
                return tabBarItem
            }

            return nil
        }
    }

    override var title: String? {
        set {
            super.title = newValue
        }
        get {
            return rootViewController?.title
        }
    }

    override var childForStatusBarStyle: UIViewController? {
        return rootViewController
    }

    override var childForStatusBarHidden: UIViewController? {
        return rootViewController
    }

    class func wrapViewController(_ viewController: UIViewController) -> WrapViewController {
        let wrapNavController: WrapNavigationController = WrapNavigationController()
        wrapNavController.viewControllers = [viewController]

        let wrapViewController: WrapViewController = WrapViewController()
        wrapViewController.view.addSubview(wrapNavController.view)
        wrapViewController.addChild(wrapNavController)

        viewController.s_wrapViewController = wrapViewController

        return wrapViewController
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let barController = tabBarController else {
            return
        }

        if s_tabBarRectValue == nil {
            s_tabBarRectValue = NSValue.init(cgRect: barController.tabBar.frame)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        guard let tabBarController = tabBarController, let rootController = rootViewController else {
            return
        }

        if rootController.hidesBottomBarWhenPushed {
            tabBarController.tabBar.frame = CGRect.zero
        }
    }

    override func viewWillAppear(_ animated: Bool) {
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
