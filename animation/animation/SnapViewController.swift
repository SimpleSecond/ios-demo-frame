//
//  SnapViewController.swift
//  animation
//
//  Created by WangDongya on 2018/2/1.
//  Copyright © 2018年 wdy-test. All rights reserved.
//

import UIKit

class SnapViewController: UIViewController {

    @IBOutlet weak var box: UIImageView!
    
    var animator   : UIDynamicAnimator!
    var snap       : UISnapBehavior!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.animator = UIDynamicAnimator.init(referenceView: self.view)
    }

    @IBAction func handleSnapGesture(_ sender: Any) {
        
        let gesture = sender as! UITapGestureRecognizer
        let _point = gesture.location(in: self.view)
        // 移除甩行为
        if self.snap != nil {
            self.animator.removeBehavior(self.snap)
        }
        self.snap = UISnapBehavior.init(item: self.box, snapTo: _point)
        self.animator.addBehavior(self.snap)
        
    }
    
}
