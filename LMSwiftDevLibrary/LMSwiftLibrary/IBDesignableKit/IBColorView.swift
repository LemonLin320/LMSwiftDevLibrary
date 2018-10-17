//
//  IBColorView.swift
//  LMSwiftLibrary
//
//  Created by Tim on 2018/10/17.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit

@IBDesignable
class IBColorView: UIView {
    private var imageView: UIImageView = UIImageView()
    private var renderSize: CGSize?
    
    @IBInspectable var color: UIColor = .white {
        didSet {
            if color != oldValue { updateRadiusColorView() }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            if cornerRadius != oldValue { updateRadiusColorView() }
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            if cornerRadius != oldValue { updateRadiusColorView() }
        }
    }
    
    override var backgroundColor: UIColor? {
        set {
            // do nothing
        }
        get {
            return nil
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.backgroundColor = .clear
        
        updateRadiusColorView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.backgroundColor = .clear
        
        updateRadiusColorView()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
    }
    
    override func awakeFromNib() {
        updateRadiusColorView()
    }
    
    private func updateRadiusColorView() {
        super.backgroundColor = .clear
        imageView.frame = self.bounds
        
        if borderWidth > 0 {
            imageView.image = UIImage.borderImage(withColor: color, cornerRadius: cornerRadius, lineWidth: borderWidth)
        } else if cornerRadius > 0 {
            imageView.image = UIImage.imageAutoResized(withColor: color, cornerRadius: cornerRadius)
        } else {
            imageView.image = UIImage.image(withColor: color, size: CGSize(width: 2, height: 2)).resizableImage(withCapInsets: UIEdgeInsetsMake(1, 1, 1, 1))
        }
        if imageView.superview == nil {
            insertSubview(imageView, at: 0)
        }
        sendSubview(toBack: imageView)
    }
}
