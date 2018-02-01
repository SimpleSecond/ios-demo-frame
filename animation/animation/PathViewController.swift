//
//  PathViewController.swift
//  animation
//
//  Created by WangDongya on 2018/2/1.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class PathViewController: UIViewController, CAAnimationDelegate {

    @IBOutlet weak var ball: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
    }
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        NSLog("动画结束!!!")
        
    }
    
    @IBAction func moveBall(_ sender: Any) {
        
        let ballPath = CGMutablePath.init()
        ballPath.move(to: CGPoint.init(x: 160.0, y: 100.0))
        ballPath.addLine(to: CGPoint.init(x: 100.0, y: 280.0))
        ballPath.addLine(to: CGPoint.init(x: 260.0, y: 170.0))
        ballPath.addLine(to: CGPoint.init(x: 60.0, y: 170.0))
        ballPath.addLine(to: CGPoint.init(x: 220.0, y: 280.0))
        ballPath.closeSubpath()
        
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        animation.duration = 10.0
        animation.path = ballPath
        animation.delegate = self
        self.ball.layer.add(animation, forKey: "position")
        
    }
    

}
