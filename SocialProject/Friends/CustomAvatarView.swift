//
//  CustomAvatarViewCell.swift
//  SocialProject
//
//  Created by Irina Kuligina on 17.10.2021.
//

import UIKit

class CustomAvatarView: UIView {
    @IBInspectable var shadowOpacity: Float = 0.8 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 8 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    lazy var imageView: UIImageView = {
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius =  imageView.frame.height / 2
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
        return imageView
    }()
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
