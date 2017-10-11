//
//  User.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 11/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift
import Realm

class User : Object{
    @objc dynamic var username : String = ""  //用户名
    @objc dynamic var tel : String = ""       //账号
    @objc dynamic var password : String = ""   //密码
    @objc dynamic var userID : String = ""         //用户id
    @objc dynamic var uuid : String = ""      //用户uuid
    
    override static func primaryKey() -> String? {
        return "userID"
    }


    
//
//    init(_ username : String,
//         _ tel : String,
//         _ password : String,
//         _ userID : String,
//         _ uuid : String) {
//        self.username = username
//        self.tel = tel
//        self.password = password
//        self.userID = userID
//        self.uuid = uuid
//    }
    
//    convenience init(_ json : JSON){
//        self.init(json["username"].stringValue,
//                  json["tel"].stringValue,
//                  json["password "].stringValue,
//                  json["id"].stringValue,
//                  json["uuid"].stringValue)
//    }
//
//    required init(value: Any, schema: RLMSchema) {
//        fatalError("init(value:schema:) has not been implemented")
//    }
//
//    required init(realm: RLMRealm, schema: RLMObjectSchema) {
//        fatalError("init(realm:schema:) has not been implemented")
//    }
//
//    required init() {
//        fatalError("init() has not been implemented")
//    }
//
//    func toJSON() -> JSON{
//        return JSON([
//            "username": username,
//            "tel": tel,
//            "password": password,
//            "id": userID,
//            "uuid": uuid
//            ])
//    }
}
