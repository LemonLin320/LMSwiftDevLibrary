//
//  IBButton.swift
//  LMSwiftLibrary
//
//  Created by Tim on 2018/10/17.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit

@IBDesignable
public class IBButton: UIButton {
    
    override public func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let margin: CGFloat = pointExtend
        let area = bounds.insetBy(dx: -margin, dy: -margin)
        return area.contains(point)
    }
    
    @IBInspectable var pointExtend: CGFloat = 0
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            updateBackgroundRadiusImage()
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            updateBackgroundRadiusImage()
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }
    @IBInspectable var gradient: Bool = false {
        didSet {
            updateBackgroundRadiusImage()
        }
    }
    @IBInspectable var beginColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }
    @IBInspectable var endColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }
    @IBInspectable var normalColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }
    @IBInspectable var selectedColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }
    @IBInspectable var highlightedColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }
    @IBInspectable var disabledColor: UIColor? {
        didSet {
            updateBackgroundRadiusImage()
        }
    }
    
#if !TARGET_INTERFACE_BUILDER
    private var renderSize: CGSize?
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if renderSize != self.bounds.size {
            updateBackgroundRadiusImage()
            renderSize = self.bounds.size
        }
    }
#endif
    
    private func updateBackgroundRadiusImage() {
        guard bounds.size.width > 0, bounds.size.height > 0 else {
            return
        }
        
        if gradient == true {
            let left = beginColor ?? UIColor.init(rgb: 0xF7CC7C)
            let right = endColor ?? UIColor.init(rgb: 0xBA9756)
            let image = UIImage.gradientImage(colors: [left, right], size: bounds.size, locations: [0.3, 1], mode: .horizontal)
            setRadiusBackgroundImage(image, for: .normal)
        } else if let color = normalColor {
            let image = UIImage.image(withColor: color, size: self.bounds.size)
            setRadiusBackgroundImage(image, for: .normal)
        }
        
        if let color = selectedColor {
            let image = UIImage.image(withColor: color, size: self.bounds.size)
            setRadiusBackgroundImage(image, for: .selected)
            setRadiusBackgroundImage(image, for: [.highlighted, .selected])
        }
        if let color = highlightedColor {
            let image = UIImage.image(withColor: color, size: self.bounds.size)
            setRadiusBackgroundImage(image, for: .highlighted)
        }
        if let color = disabledColor {
            let image = UIImage.image(withColor: color, size: self.bounds.size)
            setRadiusBackgroundImage(image, for: .disabled)
        }
    }
    
    private func setRadiusBackgroundImage(_ image: UIImage?, for state: UIControlState) {
        var image = image
        if let img = image, cornerRadius > 0 {
            image = Toucan(image: img).maskWithRoundedRect(cornerRadius: CGFloat.minimum(self.bounds.size.height/2, cornerRadius), borderWidth: borderWidth, borderColor: borderColor != nil ? borderColor! :  UIColor.white).image
        }
        setBackgroundImage(image, for: state)
    }
}
