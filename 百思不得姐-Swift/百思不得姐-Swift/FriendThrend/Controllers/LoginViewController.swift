//
//  LoginViewController.swift
//  百思不得姐-Swift
//
//  Created by Weili on 2016/11/10.
//  Copyright © 2016年 OuerTech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func shouRegisterView(_ sender: UIButton) {
        if leftConstraint.constant == 0 {
            leftConstraint.constant = -view.width
            sender.isSelected = true
        }else {
            leftConstraint.constant = 0
            sender.isSelected = false
        }
       
        UIView.animate(withDuration: 0.3, animations: animation)
    }
    
    func animation() {
        self.view.layoutIfNeeded()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
