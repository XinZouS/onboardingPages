//
//  PageCell.swift
//  onboardingPage
//
//  Created by Xin Zou on 1/23/17.
//  Copyright © 2017 Xin Zou. All rights reserved.
//

import UIKit

class PageCell : UICollectionViewCell {
    
    var page : Page? {
        didSet {
            guard let page = page else {return}
            
            imageView.image = UIImage(named: page.imgName!)
            
            //textView.text = page.title! + "\n\n" + page.text!
            // a better way to set title and content: 
            let color = UIColor(white: 0.2, alpha: 1)
            let attribute = [NSFontAttributeName : UIFont.systemFont(ofSize: 20, weight: UIFontWeightMedium),
                             NSForegroundColorAttributeName: color]
            let contentAttribute = [NSFontAttributeName : UIFont.systemFont(ofSize: 15, weight: UIFontWeightThin),
                                    NSForegroundColorAttributeName: color]
            // put text inside: // if want it center verticle, use [contentInset] in textView;
            let attributedText = NSMutableAttributedString(string: page.title!, attributes: attribute)
            attributedText.append(NSMutableAttributedString(string: "\n\n\(page.text!)", attributes: contentAttribute) )

            // then setup pargraph style, alignment == center:
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let len = attributedText.string.characters.count
            let textRanget = NSRange(location: 0, length: len)
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: textRanget)
            
            textView.attributedText = attributedText
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCells()
        
    }
    
    let imageView : UIImageView = {
        let v = UIImageView()
        //v.backgroundColor = UIColor.yellow
        v.image = UIImage(named: "page1")
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        return v
    }()
    
    let lineSeparator : UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return v
    }()
    
    let textView : UITextView = {
        let v = UITextView()
        v.text = "fs  fds af ds fds a fdsa f adsf"
        v.isEditable = false
        v.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return v
    }()
    
    func setupCells(){
        self.backgroundColor = .white // .green
        
        self.addSubview(textView)
        textView.anchorWithConstantsToTop(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topConstant: (self.frame.height / 4 * 3), bottomConstant: 0, leftConstant: 16, rightConstant: 16)

        self.addSubview(lineSeparator)
        lineSeparator.anchorToTop(top: nil, bottom: textView.topAnchor, left: leftAnchor, right: rightAnchor)
        lineSeparator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        self.addSubview(imageView)
        imageView.anchorToTop(top: topAnchor, bottom: lineSeparator.topAnchor, left: leftAnchor, right: rightAnchor)
    }
    
    // added automatically:
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

