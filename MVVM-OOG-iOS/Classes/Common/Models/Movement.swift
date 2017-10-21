//
//  Movement.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 13/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class Movement : Object{
    @objc dynamic var movementID : String = ""
    @objc dynamic var content : String = ""
    @objc dynamic var imageNumber : Float = 0.0
//    @objc dynamic var imageUrls : String = ""
    @objc dynamic var owner_avatar : String = ""
    @objc dynamic var owner_userName : String = ""
    @objc dynamic var owner_position : String = ""
    
    override static func primaryKey() -> String? {
        return "movementID"
    }
}
