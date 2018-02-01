//
//  ImplicitViewController.swift
//  animation
//
//  Created by WangDongya on 2018/2/1.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class ImplicitViewController: UIViewController {

    
    @IBOutlet weak var ball: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        self.ball.layer.opacity = 0.25
    }

    @IBAction func movePlane(_ sender: Any) {
        let moveTransform = CGAffineTransform.init(translationX: 180, y: 120)
        self.ball.layer.setAffineTransform(moveTransform)
        self.ball.layer.opacity = 1
    }

}
