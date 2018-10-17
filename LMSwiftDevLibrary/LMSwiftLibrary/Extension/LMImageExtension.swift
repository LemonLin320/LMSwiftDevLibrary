//
//  LMImageExtension.swift
//  LMSwiftLibrary
//
//  Created by Tim on 2018/10/17.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit

enum LMGradientImageMode {
    case horizontal
    case vertical
}

extension UIImage {
    static func image(withColor color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func image(withColor color: UIColor, size: CGSize, cornerRadius: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let borderPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        borderPath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func imageAutoResized(withColor color: UIColor, cornerRadius: CGFloat) -> UIImage {
        let i = cornerRadius + 1
        let s = cornerRadius * 2 + 2
        let size = CGSize(width: s, height: s)
        let insets = UIEdgeInsets(top: i, left: i, bottom: i, right: i)
        let image = self.image(withColor: color, size: size, cornerRadius: cornerRadius)
        
        return image.resizableImage(withCapInsets: insets, resizingMode: UIImageResizingMode.stretch)
    }
    
    static func borderImage(withColor color: UIColor, cornerRadius: CGFloat, lineWidth: CGFloat) -> UIImage {
        let i = cornerRadius + 1
        let s1 = cornerRadius * 2 + 2
        let s2 = lineWidth * 2 + 2
        let s = max(s1, s2)
        let size = CGSize(width: s, height: s)
        let insets = UIEdgeInsets(top: i, left: i, bottom: i, right: i)
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.setStrokeColor(color.cgColor)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let borderPath = UIBezierPath(roundedRect: rect.insetBy(dx: lineWidth/2, dy: lineWidth/2), cornerRadius: cornerRadius)
        borderPath.lineWidth = lineWidth
        borderPath.stroke()
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image.resizableImage(withCapInsets: insets, resizingMode: UIImageResizingMode.stretch)
    }
    
    static func circleImage(withColor color: UIColor, radius: CGFloat) -> UIImage {
        let size = CGSize.init(width: radius*2, height: radius*2)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.addEllipse(in: rect)
        context.fillPath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    static func gradientImage(colors: [UIColor], size: CGSize, locations: [Float] = [], mode: LMGradientImageMode) -> UIImage {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(origin: CGPoint.zero, size: size)
        gradientLayer.colors = colors.map{ $0.cgColor }
        
        switch mode {
        case .horizontal:
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        case .vertical:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        }
        
        if locations.count > 0 {
            gradientLayer.locations = locations.map{ NSNumber(value: $0) }
        }
        
        UIGraphicsBeginImageContextWithOptions(gradientLayer.bounds.size, false, 0)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return gradientImage
    }
}


