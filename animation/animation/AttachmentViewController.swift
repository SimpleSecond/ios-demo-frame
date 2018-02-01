//
//  AttachmentViewController.swift
//  animation
//
//  Created by WangDongya on 2018/2/1.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class AttachmentViewController: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var attachmentPoint: UIImageView!
    @IBOutlet weak var box: UIImageView!
    @IBOutlet weak var barrier: UIImageView!
    
    var animator    : UIDynamicAnimator!
    var attach      : UIAttachmentBehavior!
    var gravity     : UIGravityBehavior!
    var collision   : UICollisionBehavior!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animator = UIDynamicAnimator.init(referenceView: self.view)
        // 重力行为
        self.gravity = UIGravityBehavior.init(items: [self.box])
        // 设置重力方向
//        let gravityDirection : CGVector = CGVector.init(dx: 0.0, dy: 0.1)
//        self.gravity!.gravityDirection = gravityDirection
        self.animator.addBehavior(self.gravity)
        
        // 碰撞行为
        self.collision = UICollisionBehavior.init(items: [self.box])
        
        let width = self.barrier.frame.size.width
        let origin = self.barrier.frame.origin
        self.collision.addBoundary(withIdentifier: "barrier" as NSCopying, from: origin, to: CGPoint.init(x: origin.x + width, y: origin.y))
        self.collision.translatesReferenceBoundsIntoBoundary = true
        self.collision.collisionDelegate = self
        self.animator.addBehavior(self.collision)
        
        let itemBehaviour = UIDynamicItemBehavior.init(items: [self.box])
        itemBehaviour.elasticity = 0.5
        self.animator.addBehavior(itemBehaviour)
        
    }
    
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        // 设置吸附行为
        self.attach = UIAttachmentBehavior.init(item: self.attachmentPoint, attachedTo: self.box)
        self.animator.addBehavior(self.attach)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.view.backgroundColor = UIColor.white
        // Dispose of any resources that can be recreated.
    }
    
    
    

}
