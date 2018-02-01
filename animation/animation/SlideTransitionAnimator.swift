//
//  SlideTransitionAnimator.swift
//  animation
//
//  Created by WangDongya on 2018/1/31.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class SlideTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.5;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        let transformedStartFrame = toVC!.view.frame
        
        let origin = transformedStartFrame.origin
        let width = transformedStartFrame.width
        let height = transformedStartFrame.height
        
        let transformedEndFrame = CGRect.init(x: origin.x - width, y: origin.y, width: width, height: height)
        
        transitionContext.containerView.addSubview(fromVC!.view)
        transitionContext.containerView.addSubview(toVC!.view)
        
        NSLog("执行动画!!!")
        
        UIView.animate(withDuration: 0.5, animations: {
            toVC!.view.frame = transformedEndFrame
            toVC!.view.alpha = 0.5
        }) { (finished) in
            toVC!.view.frame = transformedStartFrame
            toVC!.view.alpha = 1.0;
            transitionContext.completeTransition(true)
        }
        
    }
    

}
