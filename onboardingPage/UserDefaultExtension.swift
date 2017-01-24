//
//  UserDefaultExtension.swift
//  onboardingPage
//
//  Created by Xin Zou on 1/24/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultKeys : String {
        case isLoggedIn
    }
    
    func setIsLoggedIn(value: Bool){
        //set(value, forKey: "kkk")
        set(value, forKey: UserDefaultKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLogIn() -> Bool {
        return bool(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }
    
}

