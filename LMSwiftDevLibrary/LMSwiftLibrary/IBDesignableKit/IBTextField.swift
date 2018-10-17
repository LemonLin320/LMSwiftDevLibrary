//
//  IBTextField.swift
//  LMSwiftLibrary
//
//  Created by Tim on 2018/10/17.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit

@IBDesignable
class IBTextField: UITextField {
    
    @IBInspectable var placeHolderColor: UIColor? {
        didSet {
            self.setValue(placeHolderColor, forKeyPath: "placeholderLabel.textColor")
            self.setNeedsLayout()
        }
    }
}
