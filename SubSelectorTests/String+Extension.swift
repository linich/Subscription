//
//  String+Extension.swift
//  SubSelectorTests
//
//  Created by Maxim Linich on 5/22/19.
//  Copyright © 2019 Maxim Linich. All rights reserved.
//

import Foundation

fileprivate class _TestPorpuse {

}
struct LoadData {
    public static func string(fromResourceNamed name: String) -> String? {
        let bundle = Bundle(for: _TestPorpuse.self)
        guard let path = bundle.path(forResource: name, ofType: "json") else {
            return nil
        }
        do {
            return try String(contentsOfFile: path)
        }
        catch(_){
            return nil
        }
    }
}
