//
//  Copyright © 2019 ZhiweiSun. All rights reserved.
//
//  File name: SNavigationController.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2019/6/12: Created by szwathub on 2019/6/12
//

import UIKit

open class SNavigationController: UINavigationController {
    var popPanGesture: UIScreenEdgePanGestureRecognizer?
    var s_viewControllers: [UIViewController] {
        var controllers: [UIViewController] = [UIViewController]()
        for viewController in viewControllers {
            if let wrapViewController = viewController as? WrapViewController,
               let rootController = wrapViewController.rootViewController {
                controllers.append(rootController)
            }
        }

        return controllers
    }

    weak private var popGestureDelegate: AnyObject?

    required public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)

        rootViewController.s_navigationController = self
        rootViewController.s_backButtonImage      = nil
        viewControllers = [WrapViewController.wrapViewController(rootViewController)]
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBarHidden(true, animated: false)
        delegate = self as UINavigationControllerDelegate
        popGestureDelegate = interactivePopGestureRecognizer?.delegate
        let action: Selector = Selector(("handleNavigationTransition:"))
        popPanGesture = UIScreenEdgePanGestureRecognizer.init(target: popGestureDelegate, action: action)
        if let recognizer = interactivePopGestureRecognizer as? UIScreenEdgePanGestureRecognizer {
            popPanGesture?.edges = recognizer.edges
        }
        popPanGesture?.maximumNumberOfTouches = 1
    }
}


// MARK: - UINavigationControllerDelegate
extension SNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                                   animated: Bool) {

        let isRootVC: Bool = (viewController == navigationController.viewControllers.first)

        if viewController.s_fullScreenPopGestureEnabled {
            if isRootVC {
                if let gesture = popPanGesture {
                    view.removeGestureRecognizer(gesture)
                }
            } else {
                if let gesture = popPanGesture {
                    view.addGestureRecognizer(gesture)
                }
            }
            if let delegate = popGestureDelegate as? UIGestureRecognizerDelegate {
                if let recognizer = interactivePopGestureRecognizer {
                    recognizer.delegate  = delegate
                    recognizer.isEnabled = false
                }
            }
        } else {
            if let gesture = popPanGesture {
                view.removeGestureRecognizer(gesture)
            }
            if let recognizer = interactivePopGestureRecognizer {
                recognizer.delegate  = self
                recognizer.isEnabled = false
            }
        }
    }
}


// MARK: - UIGestureRecognizerDelegate
extension SNavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                                  shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        return true
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
        shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {

        return gestureRecognizer.isKind(of: UIScreenEdgePanGestureRecognizer.self)
    }
}
