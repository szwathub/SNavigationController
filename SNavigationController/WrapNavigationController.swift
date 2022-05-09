//
//  Copyright © 2019 ZhiweiSun. All rights reserved.
//
//  File name: WrapNavigationController.swift
//  Author:    Zhiwei Sun @szwathub
//  E-mail:    szwathub@gmail.com
//
//  Description:
//
//  History:
//      2019/6/12: Created by szwathub on 2019/6/12
//

import UIKit

final class WrapNavigationController: UINavigationController {

    override func popViewController(animated: Bool) -> UIViewController? {
        return navigationController?.popViewController(animated: animated)
    }

    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return navigationController?.popToRootViewController(animated: animated)
    }

    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        if let navController = viewController.s_navigationController,
           let index = navController.s_viewControllers.firstIndex(of: viewController) {

            return navigationController?.popToViewController(navController.viewControllers[index],
                                                                  animated: animated)
        }

        return []
    }

    override func s_setViewControllers(_ viewControllers: [UIViewController], _ animated: Bool) {
        var result: [WrapViewController] = [WrapViewController]()

        for viewController in viewControllers {
            if let wrapController = viewController.wrapViewController {
                result.append(wrapController)
            } else {
                viewController.s_navigationController = navigationController as? SNavigationController

                let otherItems: [UIBarButtonItem] = viewController.configLeftBarButtonItems()
                let backButtonItem: UIBarButtonItem = UIBarButtonItem(image: viewController.backButtonImage,
                                                                      style: .plain,
                                                                     target: self,
                                                                     action: .backButtonTap)

                var allItems: [UIBarButtonItem] = [UIBarButtonItem]()
                allItems.append(backButtonItem)
                if !otherItems.isEmpty {
                    allItems.append(contentsOf: otherItems)
                }
                viewController.navigationItem.setLeftBarButtonItems(allItems, animated: true)

                result.append(WrapViewController.wrapViewController(viewController))
            }
        }

        navigationController?.setViewControllers(result, animated: animated)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.s_navigationController = navigationController as? SNavigationController

        let otherItems: [UIBarButtonItem] = viewController.configLeftBarButtonItems()

        let backButtonItem = UIBarButtonItem(image: viewController.backButtonImage,
                                             style: .plain,
                                            target: self,
                                            action: .backButtonTap)
        var allItems: [UIBarButtonItem] = [UIBarButtonItem]()
        allItems.append(backButtonItem)
        if !otherItems.isEmpty {
            allItems.append(contentsOf: otherItems)
        }
        viewController.navigationItem.setLeftBarButtonItems(allItems, animated: true)

        self.navigationController?.pushViewController(WrapViewController.wrapViewController(viewController),
                                                      animated: animated)
    }

    @objc func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

fileprivate extension Selector {
    static let backButtonTap = #selector(WrapNavigationController.didTapBackButton)
}
