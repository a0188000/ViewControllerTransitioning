//
//  PushAnimator.swift
//  Animation Controller
//
//  Created by 沈維庭 on 2021/9/2.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 執行轉場動畫
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        guard
            let fromViewCtrl = transitionContext.viewController(forKey: .from) as? animTransitionable,
            let toViewCtrl = transitionContext.viewController(forKey: .to) as? animTransitionable
        else { return }
        
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        
        let startRect = containerView.convert(fromViewCtrl.coverImageView.frame, from: fromViewCtrl.coverImageView.superview)
        let endRect = toViewCtrl.coverImageView.frame
        
        let snapshot = UIImageView(frame: startRect)
        snapshot.image = toViewCtrl.coverImageView.image
             
        let cellBackground = UIView()
        cellBackground.frame = startRect
        cellBackground.backgroundColor = .lightGray
        cellBackground.layer.cornerRadius = fromViewCtrl.cellBackground.layer.cornerRadius
        cellBackground.layer.masksToBounds = fromViewCtrl.cellBackground.layer.masksToBounds
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        containerView.addSubview(cellBackground)
        containerView.addSubview(snapshot)
        
        toVC.view.isHidden = true
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            snapshot.frame = endRect
            snapshot.layer.cornerRadius = 0
        } completion: { _ in
            snapshot.removeFromSuperview()
            cellBackground.removeFromSuperview()
            fromVC.view.removeFromSuperview()
            toVC.view.isHidden = false
            fromVC.view.alpha = 1
            transitionContext.completeTransition(true)
        }

    }
}
