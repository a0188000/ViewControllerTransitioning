//
//  PopAnimator.swift
//  Animation Controller
//
//  Created by 沈維庭 on 2021/9/2.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        guard
            let fromViewCtrl = transitionContext.viewController(forKey: .from) as? animTransitionable,
            let toViewCtrl = transitionContext.viewController(forKey: .to) as? animTransitionable
        else { return }
        
        let startRect = fromViewCtrl.coverImageView.frame
        let endRect = containerView.convert(toViewCtrl.coverImageView.frame, from: toViewCtrl.coverImageView.superview)
        
        let cellBackground = UIView()
        cellBackground.frame = endRect
        cellBackground.backgroundColor = .lightGray
        cellBackground.layer.cornerRadius = toViewCtrl.cellBackground.layer.cornerRadius
        cellBackground.layer.masksToBounds = toViewCtrl.cellBackground.layer.masksToBounds
        
        let snapshot = UIImageView(frame: startRect)
        snapshot.image = toViewCtrl.coverImageView.image
        snapshot.clipsToBounds = true
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        containerView.addSubview(cellBackground)
        containerView.addSubview(snapshot)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            snapshot.frame = endRect
            snapshot.layer.cornerRadius = toViewCtrl.cellBackground.layer.cornerRadius
        } completion: { _ in
            snapshot.removeFromSuperview()
            cellBackground.removeFromSuperview()
            toView.isHidden = false
            transitionContext.completeTransition(true)
        }

    }
}
