//
//  MotionEffectsViewController.swift
//  animation
//
//  Created by WangDongya on 2018/2/1.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class MotionEffectsViewController: UIViewController {

    
    @IBOutlet weak var mountain: UIImageView!
    @IBOutlet weak var tree: UIImageView!
    @IBOutlet weak var animal: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        // 设置山在X轴的偏移范围-50.0~50.0
        let mountainEffectX = UIInterpolatingMotionEffect.init(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        mountainEffectX.maximumRelativeValue = 50.0
        mountainEffectX.minimumRelativeValue = -50.0
        self.mountain.addMotionEffect(mountainEffectX)
        
        // 设置树在X轴的偏移范围-100.0~100.0
        let treeEffectX = UIInterpolatingMotionEffect.init(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        treeEffectX.maximumRelativeValue = 100.0
        treeEffectX.minimumRelativeValue = -100.0
        self.tree.addMotionEffect(treeEffectX)
        
    }

}
