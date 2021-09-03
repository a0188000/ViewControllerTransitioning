//
//  TransitionCoordinator.swift
//  Animation Controller
//
//  Created by 沈維庭 on 2021/9/2.
//

import UIKit

class TransitionCoordinator: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return PushAnimator()
        case .pop:
            return PopAnimator()
        default: return nil
        }
    }
}
