//
//  IBNibExtension.swift
//  LMSwiftLibrary
//
//  Created by Tim on 2018/10/17.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit

protocol UIViewNibLoadable {
    
}
extension UIViewNibLoadable where Self: UIView {
    static func loadNib(_ nibName: String? = nil) -> Self {
        return Bundle.main.loadNibNamed(nibName ?? "\(self)", owner: nil, options: nil)?.first as! Self
    }
}


protocol UIViewControllerNibInitLoadable {
    
}
extension UIViewControllerNibInitLoadable where Self: UIViewController {
    static func initNib(_ nibName: String? = nil) -> Self {
        return Self.init(nibName: nibName ?? "\(self)", bundle: Bundle.main)
    }
}


protocol StoryboardIdentifiable {
    static var storyboardName: String { get }
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    
    static func instantiateFromStoryboard() -> Self {
        let storyboardName = Self.storyboardName
        let identifier = Self.storyboardIdentifier
        
        if !identifier.isEmpty {
            guard let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateViewController(withIdentifier: identifier) as? Self else {
                fatalError("Couldn't instantiate view controller with: \(storyboardName) - \(identifier) ")
            }
            return viewController
        } else {
            guard let viewController = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController() as? Self else {
                fatalError("Couldn't instantiate view controller with identifier \(storyboardName)")
            }
            return viewController
        }
    }
    
    static var storyboardIdentifier: String? {
        return ""
    }
}


private var sendValueBackKey: String = "sendValueBackKey"
typealias sendValueBackClosureType = (_ value: Any) -> Void

extension UIViewController {
    var sendValueBackClosure: sendValueBackClosureType? {
        get {
            return objc_getAssociatedObject(self, &sendValueBackKey) as? sendValueBackClosureType
        }
        set(newValue) {
            objc_setAssociatedObject(self, &sendValueBackKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
