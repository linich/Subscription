//
//  UINavigationBar.swift
//  SubSelector
//
//  Created by Maxim Linich on 5/18/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import UIKit

let emptyImage = UIImage()
extension UINavigationBar {
    func hideBottomShadow(){
        shadowImage = emptyImage
        setBackgroundImage(emptyImage, for: .default)
    }
}
