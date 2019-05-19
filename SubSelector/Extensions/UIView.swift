//
//  UIView.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/19/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

extension UIView {

    func  set(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
