//
//  OOGUserDefault.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 22/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

private let uuidKey = "uuid"
private let ifLoginKey = "ifLogin"

class OOGUserDefault{
    static let defaults = UserDefaults.standard
    
    public static var ifLogin: Bool{
        set{
            defaults.set(newValue, forKey: ifLoginKey)
        }
        get{
            return defaults.bool(forKey: ifLoginKey)
        }
    }
    
    public static var uuid: String{
        set{
            defaults.set(newValue, forKey: uuidKey)
        }
        get{
            if let uuid = defaults.string(forKey: uuidKey){
                return uuid
            }else{
                return ""
            }
        }
    }
    
//    public func cleanAllUserDefault(){
//        OOGUserDefault.uuid = nil
//        OOGUserDefault.ifLogin = nil
//    }
    
    
//    private func set(_ key: String, _ value : Any) {
//        OOGUserDefault.defaults.set(value, forKey: key)
//    }

//    private func get(_ key: String) -> AnyObject {
//        if let value = OOGUserDefault.defaults.object(forKey: key){
//            return value
//        }
//        return nil
//    }
    
}
