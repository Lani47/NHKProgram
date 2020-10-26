//
//  NHKProperties.swift
//  NHKproject
//
//  Created by cmStudent on 2020/08/18.
//  Copyright © 2020 20CM0103. All rights reserved.
//

import Foundation
class  NHKProperties {
    static let shared = NHKProperties()
    
    private init() {}
    
    let prop: [String : String] = {
        if let nhkPath = Bundle.main.path(forResource: "nhk", ofType: "plist") {
            return (NSDictionary(contentsOfFile: nhkPath) as! Dictionary<String, String>)
        } else {
            return [:]
        }
    }()
}
