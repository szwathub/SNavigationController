//
//  Copyright © 2019 ZhiweiSun. All rights reserved.
//
//  File name: SNavigationControllerExtension.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2019/6/13: Created by szwathub on 2019/6/13
//

import UIKit

@objc protocol SNavigationItemsConfiguration {
    @objc optional func configLeftBarButtonItems() -> [UIBarButtonItem]
}

extension UIViewController {
    private struct AssociatedKeys {
        static var backButtonImage: String = "com.snavigationcontroller.backbuttonimage"
        static var popGesture: String = "com.snavigationcontroller.popgesture"
        static var navigationController: String = "com.snavigationcontroller.navigationcontroller"
        static var wrapViewController: String = "com.snavigationcontroller.wrapViewcontroller"
    }

    @objc public var backButtonImage: UIImage? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.backButtonImage) as? UIImage
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.backButtonImage, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc public var fullScreenPopGestureEnabled: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.popGesture) != nil)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.popGesture, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    @objc public var s_navigationController: SNavigationController? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.navigationController) as? SNavigationController
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.navigationController, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    var wrapViewController: WrapViewController? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.wrapViewController) as? WrapViewController
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.wrapViewController, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

extension UIViewController: SNavigationItemsConfiguration {
    open func configLeftBarButtonItems() -> [UIBarButtonItem] {
        return []
    }
}

extension UINavigationController {
    @objc public func s_setViewControllers(_ viewControllers: [UIViewController], _ animated: Bool) {
        print("s_setViewControllers")
    }
}
