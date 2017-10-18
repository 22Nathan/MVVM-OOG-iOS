//
//  ValidInputHelper.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 18/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

class ValidInputHelper{
    class func isValidTel(tel: String) -> Bool{
        return tel.characters.count == 11
    }
    
    class func isValidPassword(password: String) -> Bool{
        return password.characters.count >= 5
    }
}
