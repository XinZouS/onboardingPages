//
//  HomeController.swift
//  onboardingPage
//
//  Created by Xin Zou on 1/24/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit



class HomeController : UIViewController {
    
    let lab : UILabel = {
        let l = UILabel()
        l.text = "this is HomeController page; "
        l.tintColor = UIColor.orange
        l.contentMode = .center
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellow
        
        navigationItem.title = "User logged in"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignOut))
        
        self.view.addSubview(lab)
        _ = lab.anchor(self.view.topAnchor, view.leftAnchor, nil, view.rightAnchor, topConstraint: 200, leftConstraint: 30, bottomConstraint: 0, rightConstraint: 30, widthConstraint: 0, heightConstraint: 30)
        
    }
    
    func handleSignOut(){
        //UserDefaults.standard.set(false, forKey: "isLoggedIn")
        //UserDefaults.standard.synchronize()
        //use ExtensionUserDefaults to replace above 2 lines: 
        UserDefaults.standard.setIsLoggedIn(value: false)
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
    
}

