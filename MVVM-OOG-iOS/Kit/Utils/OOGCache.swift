//
//  OOGCache.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 12/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class OOGCache{
    static let myCache = UserDefaults.standard
    var key : String
    
    var value : String{
        set{
            set(key, newValue)
        }
        get{
            return get(key)
        }
    }
    
    var isEmpty : Bool{
        return value == ""
    }
    
    init(_ key : String) {
        self.key = key
    }
    
    private func set(_ key : String, _ value : String) {
        OOGCache.myCache.set(value, forKey: key)
    }
    
    private func get(_ key : String) -> String {
        if let value = OOGCache.myCache.string(forKey: key){
            return value
        }
        return ""
    }
}
