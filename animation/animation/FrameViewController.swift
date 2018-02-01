//
//  FrameViewController.swift
//  animation
//
//  Created by WangDongya on 2018/2/1.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class FrameViewController: UIViewController {

    
    @IBOutlet weak var ball: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }

    @IBAction func moveBall(_ sender: Any) {
        
        let opAnim = CAKeyframeAnimation.init(keyPath: "opacity")
        opAnim.duration = 6.0
        opAnim.values = [0.25, 0.75, 1.0]
        opAnim.keyTimes = [0.0, 0.5, 1.0]
        
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
