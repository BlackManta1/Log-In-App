//
//  LoginCell.swift
//  Collection View App
//
//  Created by Saliou DJALO on 11/08/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

import Foundation
import UIKit

class LoginCell: UICollectionViewCell {
    
    let imageLogo: UIImageView = {
        let im = UIImage(named: IMG_LOGO)
        let imgView = UIImageView(image: im)
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let emailTextField: UITextFieldLeftPadding = {
        let tf = UITextFieldLeftPadding()
        tf.placeholder = "Enter email"
        tf.keyboardType = UIKeyboardType.emailAddress
        tf.layer.borderColor = PURE_LIGHT_GRAY.cgColor
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let passwordTextField: UITextFieldLeftPadding = {
        let tf = UITextFieldLeftPadding()
        tf.placeholder = "Enter password"
        tf.keyboardType = UIKeyboardType.default
        tf.isSecureTextEntry = true
        tf.layer.borderColor = PURE_LIGHT_GRAY.cgColor
        tf.layer.borderWidth = 1
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 0/255, green: 179/255, blue: 0/255, alpha: 1)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let policyTextView: UITextView = {
        let tv = UITextView()
        let attributedText = NSMutableAttributedString(string: "By creating an account you agree to our ", attributes: [.font: UIFont.systemFont(ofSize: 13, weight: .medium), .foregroundColor: UIColor.gray])
        attributedText.append(NSAttributedString(string: "Terms of Services ", attributes: [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "and ", attributes: [.font: UIFont.systemFont(ofSize: 13, weight: .medium), .foregroundColor: UIColor.gray]))
        attributedText.append(NSAttributedString(string: "Privacy Policy.", attributes: [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.black]))
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let lengthNSRange = attributedText.string.count
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: lengthNSRange))
        
        tv.attributedText = attributedText
        tv.isEditable = false
        return tv
    }()
    
    let alreadyAccountTextView: UITextView = {
        let tv = UITextView()
        let attributedText = NSMutableAttributedString(string: "Don't have an account? ", attributes: [.font: UIFont.systemFont(ofSize: 19), .foregroundColor: PURE_LIGHT_GRAY])
        attributedText.append(NSAttributedString(string: "Sign Up", attributes: [.font: UIFont.boldSystemFont(ofSize: 19), .foregroundColor: UIColor.red]))
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let lengthNSRange = attributedText.string.count
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: lengthNSRange))
        
        tv.attributedText = attributedText
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLoginCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpLoginCell() {
        
        addSubview(imageLogo)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(policyTextView)
        addSubview(alreadyAccountTextView)
        
        _ = imageLogo.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -280, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        imageLogo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = emailTextField.anchor(imageLogo.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = passwordTextField.anchor(emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 10, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = loginButton.anchor(passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = policyTextView.anchor(loginButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 12, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 50)
        
        _ = alreadyAccountTextView.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 16, rightConstant: 16, widthConstant: 0, heightConstant: 50)
        
    }
    
}
