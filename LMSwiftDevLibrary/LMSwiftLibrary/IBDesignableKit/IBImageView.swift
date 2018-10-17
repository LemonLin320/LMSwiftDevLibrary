//
//  IBImageView.swift
//  LMSwiftLibrary
//
//  Created by Tim on 2018/10/17.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit

@IBDesignable
class IBImageView: UIImageView {
    private var shouldRender: Bool = false
    private var renderSize = CGSize.zero
    private var enableRender = true

    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            #if TARGET_INTERFACE_BUILDER
                IDUpdateImage()
            #else
                if cornerRadius != oldValue { setNeedsRender() }
            #endif
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            #if TARGET_INTERFACE_BUILDER
                IDUpdateImage()
            #else
                if borderWidth != oldValue { setNeedsRender() }
            #endif
        }
    }
    
    @IBInspectable
    var borderColor: UIColor = .clear {
        didSet {
            #if TARGET_INTERFACE_BUILDER
                IDUpdateImage()
            #else
                if borderColor != oldValue { setNeedsRender() }
            #endif
        }
    }

    override var image: UIImage? {
        didSet {
            #if TARGET_INTERFACE_BUILDER
                if enableRender {
                    IDUpdateImage()
                }
            #else
                if image != oldValue { setNeedsRender() }
            #endif
        }
    }

    override var contentMode: UIViewContentMode {
        didSet {
            #if TARGET_INTERFACE_BUILDER
                IDUpdateImage()
            #else
                if contentMode != oldValue { setNeedsRender() }
            #endif
        }
    }
    
    private func setNeedsRender() {
        if enableRender {
            shouldRender = true
            setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shouldRender || renderSize != frame.size {
            shouldRender = false
            renderSize = frame.size
            IDUpdateImage()
        }
    }
    
    private func IDUpdateImage() {
        if !enableRender || cornerRadius <= 0 || self.image == nil {
            return
        }
        if bounds.size.width <= 0 && bounds.size.height <= 0 {
            return
        }

        enableRender = false

        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        if self.borderWidth > 0 {
            context.setFillColor(borderColor.cgColor)
            let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
            path.fill()
        }
        
        let w = CGFloat.maximum(self.borderWidth, 0)
        context.addPath(UIBezierPath.init(roundedRect: self.bounds.insetBy(dx: w, dy: w), cornerRadius: cornerRadius).cgPath)
        context.clip()
        self.layer.render(in: context)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.image = image
        enableRender = true
    }
}

