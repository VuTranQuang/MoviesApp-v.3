//
//  ViewController.swift
//  MoviesApp v.3
//
//  Created by VuTQ10 on 12/18/19.
//  Copyright © 2019 VuTQ10. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoSide: UIView!
    
    @IBOutlet weak var leadingInfoSide: NSLayoutConstraint!
    @IBOutlet weak var trainlingPopSide: NSLayoutConstraint!
    
    var isMenuShow = false {
        didSet {
            UIView.animate(withDuration: 0.35) {
                self.leadingInfoSide.constant = self.isMenuShow ? 0 : -self.infoSide.bounds.width
                self.trainlingPopSide.constant = self.isMenuShow ? -self.infoSide.bounds.width : 0
                self.view.layoutIfNeeded()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        isMenuShow = false
        NotificationCenter.default.addObserver(self, selector: #selector(isShowControl(notification:)), name: Notification.Name("isMenuShow"), object: nil)
        
         NotificationCenter.default.addObserver(self, selector: #selector(openMenuForInforKeep(_:)), name: Notification.Name("Keep"), object: nil)
    }
    @objc func isShowControl(notification: NSNotification) {
        togg()
    }
    @objc func openMenuForInforKeep(_ notification: NSNotification) {
        isMenuShow = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isMenuShow = false
    }
    
    func togg() {
        isMenuShow = !isMenuShow
    }
    

  

}
