//
//  CellModel.swift
//  Collection View App
//
//  Created by Saliou DJALO on 07/08/2019.
//  Copyright © 2019 Saliou DJALO. All rights reserved.
//

// command + / pour commenter une ligne rapidement

import Foundation
import UIKit

class CellModel: UICollectionViewCell {
    
    var page:Page? {
        didSet {
            guard let pg = page else { return }
            imageView.image = UIImage(named: pg.imageName)
            
            let color = UIColor(white: 0.2, alpha: 1)
            let attributedText = NSMutableAttributedString(string: pg.title, attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .medium), .foregroundColor: color])
            attributedText.append(NSAttributedString(string: "\n\n\(pg.desc)", attributes: [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: color]))
            // then
            // we center the text
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let lengthNSRange = attributedText.string.count
            attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: lengthNSRange))
            
            textView.attributedText = attributedText
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        //iv.backgroundColor = .green // testing
        iv.image = UIImage(named: IMAGE_PAGE_1)!
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // plusieurs lignes de texte que lon peut scroller et rendre editable ou pas>
    let textView: UITextView = {
        let tv = UITextView()
        tv.text = "SAMPLE OF TEXT, JUST FOR CHECK IF ITS WORKING FINE!"
        tv.isEditable = false
        // nous sert a decaller le text vers le bas, avec les marges
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let lineSeparatorView: UIView = {
       let view = UIView()
       view.backgroundColor = UIColor(white: 0.9, alpha: 1)
       return view
    }()
    
    // these 2 below functions are mandatory
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setUpView() {
        backgroundColor = .white
        addSubview(imageView)
        addSubview(textView)
        addSubview(lineSeparatorView)
        
        imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        
        // here custom function, control + command + J : Jump to definition
        textView.anchorWithConstantsToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
        lineSeparatorView.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        lineSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true // height
        
    }
}
