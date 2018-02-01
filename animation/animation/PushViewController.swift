//
//  PushViewController.swift
//  animation
//
//  Created by WangDongya on 2018/2/1.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class PushViewController: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var attachmentPoint: UIImageView!
    @IBOutlet weak var box: UIImageView!
    @IBOutlet weak var barrier: UIImageView!
    
    var animator    : UIDynamicAnimator!
    var attach      : UIAttachmentBehavior!
    var gravity     : UIGravityBehavior!
    var collision   : UICollisionBehavior!
    
    var firstContact = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animator = UIDynamicAnimator.init(referenceView: self.view)
        // 重力行为
        self.gravity = UIGravityBehavior.init(items: [self.box])
        self.animator.addBehavior(self.gravity)
        
        // 碰撞行为
        self.collision = UICollisionBehavior.init(items: [self.box])
        let width  = self.barrier.frame.size.width
        let origin = self.barrier.frame.origin
        self.collision.addBoundary(withIdentifier: "barrier" as NSCopying, from: origin, to: CGPoint.init(x: origin.x + width, y: origin.y))
        
        self.collision.translatesReferenceBoundsIntoBoundary = true
        self.collision.collisionDelegate = self
        
        self.animator.addBehavior(self.collision)
        
        let itemBehaviour = UIDynamicItemBehavior.init(items: [self.box])
        itemBehaviour.elasticity = 0.5
        self.animator.addBehavior(itemBehaviour)
    }
    
    // MARK: 实现UICollisionBehaviorDelegate协议方法
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        if !self.firstContact {
            self.firstContact = true
            // 设置吸附行为
            self.attach = UIAttachmentBehavior.init(item: self.attachmentPoint, attachedTo: self.box)
            self.animator.addBehavior(self.attach)
            
            // 设置推行为
            let push = UIPushBehavior.init(items: [self.box], mode: UIPushBehaviorMode.instantaneous)
            push.setAngle(CGFloat(-Double.pi/4.0), magnitude: 5.0)
            self.animator.addBehavior(push)
        }
    }
    

}
