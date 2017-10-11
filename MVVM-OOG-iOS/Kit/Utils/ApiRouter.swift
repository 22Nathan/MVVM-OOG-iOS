//
//  ApiRouter.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 11/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import Moya

enum UserAPI{
    case Info(userID: String)
}

extension UserAPI: TargetType{
    var baseURL: URL { return URL(string: "http://101.132.41.248:8000/v1/")! }
    
    var path: String{
        switch self {
        case .Info(let userID):
            return "users/" + userID
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .Info:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .Info :
            return URLEncoding.default // Send parameters in URL for GET, DELETE and HEAD. For other HTTP methods, parameters will be sent in request body
        }
    }
    
    var sampleData: Data {
        switch self {
        case .Info(let userID):
            return "{\"UserID\": \(userID)}".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .Info:
            return .requestPlain
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    public func url(route: TargetType) -> String {
        return route.baseURL.appendingPathComponent(route.path).absoluteString
    }
}

