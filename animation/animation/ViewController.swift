//
//  ViewController.swift
//  animation
//
//  Created by WangDongya on 2018/1/31.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.delegate = self
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        NSLog("segue")
//        if segue.identifier == "TransitionModal" {
//            let destVC = segue.destination
//            destVC.transitioningDelegate = self
//        }
//    }
    
    // MARK: -- UIViewControllerTransitioningDelegate协议方法
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animator = SlideTransitionAnimator.init()
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = SlideTransitionAnimator.init()
        return animator
    }
    
    

    // MARK: -- 实现UINavigationControllerDelegate协议
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation==UINavigationControllerOperation.push {
            let animator = SlideTransitionAnimator()
            return animator
        }
        
        return nil
    }

    // MARK: -- 点击事件
    @IBAction func pushNavi(_ sender: Any) {
        
        let toVC = UIViewController.init()
        toVC.view.backgroundColor = UIColor.lightGray
        
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    @IBAction func modelVC(_ sender: Any) {
        
        let toVC = ModelViewController.init()
        toVC.transitioningDelegate = self
        
        self.present(toVC, animated: true) {
            NSLog("结束!!!")
        }
    }
    
    @IBAction func doViewAnimation(_ sender: Any) {
        
        let theBtn = sender as! UIButton
        
        switch theBtn.tag {
        case 1:
            UIView.transition(with: self.view, duration: 3.0, options: [UIViewAnimationOptions.curveEaseOut, UIViewAnimationOptions.transitionFlipFromLeft], animations: {
                NSLog("动画开始...")
            }, completion: { (finished) in
                NSLog("动画完成...")
            })
            break
        case 2:
            UIView.transition(with: self.view, duration: 3.0, options: [UIViewAnimationOptions.curveEaseOut, UIViewAnimationOptions.transitionFlipFromRight], animations: {
                NSLog("动画开始...")
            }, completion: { (finished) in
                NSLog("动画完成...")
            })
            break
        case 3:
            UIView.transition(with: self.view, duration: 3.0, options: [UIViewAnimationOptions.curveEaseOut, UIViewAnimationOptions.transitionCurlUp], animations: {
                NSLog("动画开始...")
            }, completion: { (finished) in
                NSLog("动画完成...")
            })
            break
        case 4:
            UIView.transition(with: self.view, duration: 3.0, options: [UIViewAnimationOptions.curveEaseOut, UIViewAnimationOptions.transitionCurlDown], animations: {
                NSLog("动画开始...")
            }, completion: { (finished) in
                NSLog("动画完成...")
            })
            break
        default: break
            
        }
        
    }
    
}

