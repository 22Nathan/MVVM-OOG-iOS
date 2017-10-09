//
//  ErrorHelper.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 09/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case CannotGetServerResponse
    
    var localizedDescription: String{
        switch self {
        case .CannotGetServerResponse:
            return "can not connect to server"
        default:
            return "unknown error"
        }
    }
}
