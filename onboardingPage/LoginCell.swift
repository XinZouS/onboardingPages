//
//  LoginCell.swift
//  onboardingPage
//
//  Created by Xin Zou on 1/23/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit

class LoginCell : UICollectionViewCell {
    
    let logoImg : UIImageView = {
        let i = UIImageView()
        i.image = UIImage(named: "page1")
        i.contentMode = .scaleAspectFill
        i.layer.cornerRadius = 16
        i.layer.masksToBounds = true
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
    }()
    
    let emailTextField : LeftPaddedTextField = {
        let t = LeftPaddedTextField()
        t.placeholder = "Email"
        t.layer.borderColor = UIColor.lightGray.cgColor
        t.layer.borderWidth = 1
        t.layer.cornerRadius = 6
        t.keyboardType = .emailAddress
        return t
    }()
    
    let passwordTextField : LeftPaddedTextField = {
        let t = LeftPaddedTextField()
        t.placeholder = "Password"
        t.layer.borderColor = UIColor.lightGray.cgColor
        t.layer.borderWidth = 1
        t.layer.cornerRadius = 6
        t.isSecureTextEntry = true
        return t
    }()
    
    lazy var loginButton : UIButton = {
        let b = UIButton()
        b.setTitle("Login", for: .normal)
        b.tintColor = UIColor.white
        b.backgroundColor = .orange // UIColor(red: 0.9, green: 0.6, blue: 0.4, alpha: 1)
        b.layer.cornerRadius = 6
        b.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return b
    }()
    var loginController : LoginController? // also need to set it in LoginController.cellForItemAt;
    func handleLogin() {
        loginController?.finishLoggingIn() // so that here could accept the pointer; 
    }
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        //self.backgroundColor = UIColor.cyan
        
        addSubview(logoImg)
        logoImg.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoImg.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImg.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImg.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        
        addSubview(emailTextField)
        _ = emailTextField.anchor(logoImg.bottomAnchor, leftAnchor, nil, rightAnchor, topConstraint: 30, leftConstraint: 53, bottomConstraint: 0, rightConstraint: 53, widthConstraint: 0, heightConstraint: 36)
        
        addSubview(passwordTextField)
        _ = passwordTextField.anchor(emailTextField.bottomAnchor, leftAnchor, nil, rightAnchor, topConstraint: 20, leftConstraint: 53, bottomConstraint: 0, rightConstraint: 53, widthConstraint: 0, heightConstraint: 36)
        
        addSubview(loginButton)
        _ = loginButton.anchor(passwordTextField.bottomAnchor, leftAnchor, nil, rightAnchor, topConstraint: 30, leftConstraint: 53, bottomConstraint: 0, rightConstraint: 53, widthConstraint: 0, heightConstraint: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class LeftPaddedTextField : UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
}
