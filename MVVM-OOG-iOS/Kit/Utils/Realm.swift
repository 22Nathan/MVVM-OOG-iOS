//
//  Realm.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 12/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

public func addObjc(_ object : Object, with realm: Realm ){
    try! realm.write {
        realm.add(object)
    }
}

public func updateObjc(_ object : Object, with realm: Realm){
    try! realm.write {
        realm.add(object, update: true)
    }
}
