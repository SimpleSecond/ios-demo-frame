//
//  DisplayViewController.swift
//  animation
//
//  Created by WangDongya on 2018/2/1.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    @IBOutlet weak var ball: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.ball.layer.opacity = 0.25
    }

    @IBAction func movePlane(_ sender: Any) {
        let opAnim = CABasicAnimation.init(keyPath: "opacity")
        opAnim.duration = 3.0
        opAnim.fromValue = 0.25
        opAnim.toValue = 1.0
        opAnim.isCumulative = true
        opAnim.repeatCount = 2
        opAnim.fillMode = kCAFillModeForwards
        opAnim.isRemovedOnCompletion = false
        self.ball.layer.add(opAnim, forKey: "animateOpacity")
        
        let moveTransform = CGAffineTransform.init(translationX: 180, y: 200)
        let moveAnim = CABasicAnimation.init(keyPath: "transform")
        moveAnim.duration = 6.0
        moveAnim.toValue = NSValue.init(caTransform3D: CATransform3DMakeAffineTransform(moveTransform))
        moveAnim.fillMode = kCAFillModeForwards
        moveAnim.isRemovedOnCompletion = false
        self.ball.layer.add(moveAnim, forKey: "animateTransform")
        
    }
}
