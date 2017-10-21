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
    case SubscribeMovement(userID: String)
}

extension UserAPI: TargetType{
    var baseURL: URL { return URL(string: "http://101.132.41.248:8000/v1/")! }
    
    var path: String{
        switch self {
        case .Info(let userID):
            return "users/" + userID
        case .SubscribeMovement(_):
            return "movements/all/"
        }
    }
    
    var method: Moya.Method{
        switch self {
        case .Info, .SubscribeMovement:
            return .get
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .Info:
            return URLEncoding.default
        case .SubscribeMovement:
            return JSONEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        case .Info(let userID):
            return "{\"UserID\": \(userID)}".utf8Encoded
        case .SubscribeMovement(let userID):
            return "{\"UserID\": \(userID)}".utf8Encoded
        }
    }
    
    var task: Task {
        switch self {
        case .Info:
            return .requestPlain
        case .SubscribeMovement(let userID):
            return .requestParameters(parameters: ["id" : userID], encoding: URLEncoding.queryString)
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
    
    public func url(route: TargetType) -> String {
        return route.baseURL.appendingPathComponent(route.path).absoluteString
    }
}

enum MovementAPI{
    case Detail(movementID: String)
}


