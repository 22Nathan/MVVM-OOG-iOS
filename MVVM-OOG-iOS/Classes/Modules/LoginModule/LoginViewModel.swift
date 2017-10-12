//
//  LoginViewModel.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 09/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxSwift
import Moya
import RealmSwift
import Realm

struct LoginViewModel {
    var model : LoginModel?
    
    fileprivate let loginInfoSubject = PublishSubject<String>()
    var loginInfo: Observable<String>{
        return loginInfoSubject.asObservable()
    }
    let bag = DisposeBag()
    
    func requestLogin(){
        guard let tel = model?.telephone, let password = model?.password else{
            return
        }

        var parameters = [String : String]()
        parameters["tel"] = tel
        parameters["password"] = password
        
        Alamofire.request(ApiHelper.API_Root + "users/login/",
                          method: .get, parameters: parameters, encoding: URLEncoding.default).responseJSON {response in
                            switch response.result.isSuccess {
                            case true:
                                if let value = response.result.value {
                                    let json = SwiftyJSON.JSON(value)
                                    print(json)
                                    let result = json["result"]
                                    if result == "ok"{
                                        let user = User()
                                        user.username = result["username"].stringValue
                                        user.userID = result["id"].stringValue
                                        user.uuid = result["uuid"].stringValue
                                        user.tel = tel
                                        user.password = password
                                
                                        guard let realm = try? Realm() else {
                                            return
                                        }
                                        updateObjc(user, with: realm)
                                        Cache.uuidCache.value = user.uuid
                                        
                                        self.loginInfoSubject.onNext("ok")
                                    }
                                    else{
                                        self.loginInfoSubject.onNext("wrong")
                                    }
                                    self.loginInfoSubject.onCompleted()
                                }
                            case false:
                                self.loginInfoSubject.onError(NetworkError.CannotGetServerResponse)
                            }
        }
    }
    
}
