//
//  LayerViewController.swift
//  animation
//
//  Created by WangDongya on 2018/2/1.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class LayerViewController: UIViewController {
    
    var ballLayer = CALayer.init()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let image = UIImage.init(named: "ball")
        
        self.ballLayer.contents = image?.cgImage
        self.ballLayer.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        self.ballLayer.contentsGravity = kCAGravityResizeAspect
        self.ballLayer.position = CGPoint.init(x: self.view.bounds.midX, y: self.view.bounds.midY)
        self.view.layer.addSublayer(self.ballLayer)
    }

}
