//
//  CollisionViewController.swift
//  animation
//
//  Created by WangDongya on 2018/2/1.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class CollisionViewController: UIViewController {

    @IBOutlet weak var ballImageView: UIImageView!
    
    var animator : UIDynamicAnimator!
    var gravity  : UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animator = UIDynamicAnimator.init(referenceView: self.view)
        // 重力行为
        self.gravity = UIGravityBehavior.init(items: [self.ballImageView])
        // 设置重力方向
        let gravityDirection : CGVector = CGVector.init(dx: 0.0, dy: 0.1)
        self.gravity!.gravityDirection = gravityDirection
        
        self.animator.addBehavior(self.gravity)
        
        // 碰撞行为
        self.collision = UICollisionBehavior.init(items: [self.ballImageView])
        self.collision.translatesReferenceBoundsIntoBoundary = true
        self.animator.addBehavior(self.collision)
        
    }
    


}
