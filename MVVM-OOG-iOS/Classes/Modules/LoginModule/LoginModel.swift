//
//  LoginModel.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 09/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class LoginModel{
    var telephone : String
    var password : String
    
    init(_ telephone : String, _ password : String) {
        self.telephone = telephone
        self.password = password
    }
}
