//
//  RIBs+Utils.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import UIKit
import RIBs

final class NavigationControllable: ViewControllable {
  
  var uiviewController: UIViewController { self.navigationController }
  let navigationController: UINavigationController
  
  public init(root: ViewControllable) {
      let navigation = UINavigationController(rootViewController: root.uiviewController)
      
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.shadowColor = .clear
      appearance.shadowImage = UIImage()
      appearance.backgroundColor = .white
      
      navigation.navigationBar.standardAppearance = appearance;
      navigation.navigationBar.scrollEdgeAppearance = navigation.navigationBar.standardAppearance
      
      navigation.modalPresentationStyle = .fullScreen
      
      self.navigationController = navigation
  }
}

extension ViewControllable {
  
    func present(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
        self.uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
    }

    func dismiss(completion: (() -> Void)?, animated: Bool = true) {
        self.uiviewController.dismiss(animated: animated, completion: completion)
    }

    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.pushViewController(viewControllable.uiviewController, animated: animated)
        } else {
            self.uiviewController.navigationController?.pushViewController(viewControllable.uiviewController, animated: animated)
        }
    }

    func popViewController(animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popViewController(animated: animated)
        } else {
            self.uiviewController.navigationController?.popViewController(animated: animated)
        }
    }

    func popToRoot(animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popToRootViewController(animated: animated)
        } else {
            self.uiviewController.navigationController?.popToRootViewController(animated: animated)
        }
    }

    func setViewControllers(_ viewControllerables: [ViewControllable]) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
        } else {
            self.uiviewController.navigationController?.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
        }
    }
    
    func popToSpecific(_ viewControllable: ViewControllable, animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popToViewController(viewControllable.uiviewController, animated: true)
        } else {
            self.uiviewController.navigationController?.popToViewController(viewControllable.uiviewController, animated: true)
        }
    }
}

