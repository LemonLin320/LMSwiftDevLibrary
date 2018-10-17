//
//  IBLabel.swift
//  LMSwiftLibrary
//
//  Created by Tim on 2018/10/17.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit

@IBDesignable
public class IBLabel: UILabel {

    @IBInspectable
    var leading: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    @IBInspectable
    var IBShadowColor: UIColor? {
        didSet {
            layer.shadowColor = IBShadowColor?.cgColor
            layer.shadowOpacity = 1
            layer.masksToBounds = false
        }
    }
    
    @IBInspectable
    var IBShadowRadius: CGFloat = 0 {
        didSet {
            layer.shadowRadius = IBShadowRadius
            layer.masksToBounds = false
        }
    }

    @IBInspectable
    var IBShadowOffset: CGSize = CGSize.zero {
        didSet {
            layer.shadowOffset = IBShadowOffset
            layer.masksToBounds = false
        }
    }
    
    override public var text: String? {
        didSet {
            update()
        }
    }

    override public var attributedText: NSAttributedString? {
        set {
            if let attrs = newValue {
                let paragraph = NSMutableParagraphStyle.init()
                paragraph.lineSpacing = leading
                paragraph.lineBreakMode = lineBreakMode
                paragraph.alignment = textAlignment
                
                let mutable = NSMutableAttributedString(attributedString: attrs)
                mutable.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraph, range: NSRange(location: 0, length: mutable.string.count))
                super.attributedText = mutable
            } else {
                super.attributedText = nil
            }
        }
        get {
            return super.attributedText
        }
    }
    
    private func update() {
        self.numberOfLines = 0
        let leading = CGFloat.maximum(self.leading, 0)
        
        if let text = self.text, !text.isEmpty {
            
            let paragraph = NSMutableParagraphStyle.init()
            paragraph.lineSpacing = leading
            paragraph.lineBreakMode = lineBreakMode
            paragraph.alignment = textAlignment
            
            let attr = [NSAttributedStringKey.font : font,
                        NSAttributedStringKey.foregroundColor: textColor,
                        NSAttributedStringKey.paragraphStyle: paragraph] as [NSAttributedStringKey : Any]
            
            let str = NSMutableAttributedString.init(string: text, attributes: attr)
            super.attributedText = str
        } else {
            super.attributedText = nil
        }
    }
}
