//
//  MainNavigationController.swift
//  onboardingPage
//
//  Created by Xin Zou on 1/24/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit

class MainNavigationController : UINavigationController {
    
    
    fileprivate func isLogin() -> Bool {
        return UserDefaults.standard.isLogIn()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        
        
        if isLogin() {
            let homeController = HomeController()
            viewControllers = [homeController] // system layer of controllers, we reset it;
        }else{
            perform(#selector(showLoginController), with: nil, afterDelay: 0.05)
        }
    }
    
    func showLoginController(){
        let loginController = LoginController()
        present(loginController, animated: true) {
            //after shown the page;
        }
    }
}

