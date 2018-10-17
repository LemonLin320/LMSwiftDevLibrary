//
//  IBFirstResponderAction.swift
//  LMSwiftLibrary
//
//  Created by Tim on 2018/10/17.
//  Copyright © 2018年 Tim Lin. All rights reserved.
//

import UIKit

extension UIViewController {
    @IBAction func IBPopViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func IBDismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
