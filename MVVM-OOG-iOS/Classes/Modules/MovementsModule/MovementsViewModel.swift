//
//  MovementsViewModel.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 12/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import SwiftyJSON
import Alamofire
import RealmSwift

class MovesmentViewModel {
    
    var model: [Movement] = []
    
    fileprivate let MovementSubject = PublishSubject<[Movement]>()
    var MovementList: Observable<[Movement]>{
        return MovementSubject.asObservable()
    }
    let bag = DisposeBag()
    
    func prepareData(completionHandler: @escaping ()->(),isRefresh : Bool = false){
        if isRefresh{
            requestMovements { completionHandler() }
        }else if let cacheMovements = cache.object(forKey: movementsCacheKey){
            model = self.parseMovementModel(JSON.parse(cacheMovements as! String))
            completionHandler()
            self.MovementSubject.onNext(model)
        }else{
            requestMovements { completionHandler() }
        }
    }
    
    private func requestMovements(completionHandler: @escaping ()->()){
        let realm = try! Realm()
        let currentUser = realm.objects(User.self).filter("uuid == '\(OOGUserDefault.uuid)'").first
        let provider = MoyaProvider<UserAPI>()
        
        provider.request(.SubscribeMovement(userID: (currentUser?.userID)!)) { (result) in
            switch result {
            case let .success(moyaResponse):
                let response = moyaResponse.data
                let json = JSON(response)
                // save to Cache
                cache.setObject(json.rawString()! as NSString, forKey: movementsCacheKey)
                self.model = self.parseMovementModel(json)
                completionHandler()
                self.MovementSubject.onNext(self.model)
            case .failure(_):
                self.MovementSubject.onError(NetworkError.CannotGetServerResponse)
            }
        }
    }
    
    private func parseMovementModel(_ json: JSON) -> [Movement]{
        var movementList : [Movement] = []
        
        let movments = json["movements"].arrayValue
        for movementJSON in movments{
            let movementsType = movementJSON["movementType"].intValue
            if movementsType == 3{
                continue
            }
            //parse basic info
            let movmentID = movementJSON["id"].stringValue
            let content = movementJSON["content"].stringValue
            let owner_avatar = movementJSON["owner"]["avatar_url"].stringValue
            let owner_userName = movementJSON["owner"]["username"].stringValue
            let owner_position = movementJSON["owner"]["position"].stringValue
            
            //parse imageUrl
            let imageUrlsJSON = movementJSON["image_url"].arrayValue
            var imageUrl = ""
            for url in imageUrlsJSON{
                imageUrl = url.stringValue
                break
            }
            
            let movement = Movement()
            movement.content = content
            movement.movementID = movmentID
            movement.owner_avatar = owner_avatar
            movement.owner_position = owner_position
            movement.owner_userName = owner_userName
            movement.imageUrls = imageUrl
            
            movementList.append(movement)
        }
        return movementList
    }
}
