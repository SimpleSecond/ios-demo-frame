//
//  ModelViewController.swift
//  animation
//
//  Created by WangDongya on 2018/2/1.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class ModelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let myView = UIImageView.init(image: UIImage.init(named: "ball"))
        let animator = UIDynamicAnimator.init(referenceView: self.view)
        
        let gravityDirection:CGVector = CGVector.init(dx: 0.0, dy: 0.1)
        
        let gravity = UIGravityBehavior.init(items: [myView])
        gravity.gravityDirection = gravityDirection
        animator.addBehavior(gravity)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            NSLog("视图消失!!!")
        }
    }

}
