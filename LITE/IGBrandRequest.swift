//
//  IGBrandRequest.swift
//  LITE
//
//  Created by Kenichi Saito on 9/3/17.
//  Copyright © 2017 Kenichi Saito. All rights reserved.
//

import Foundation
import APIKit
import ObjectMapper
import RealmSwift
import SwiftyJSON

struct IGBrandRequest: Request {
    var username: String
    var baseURL: URL { return URL(string: "https://www.instagram.com")! }
    var method: HTTPMethod { return .get }
    var path: String { return "/\(username)" }
    var parameters: Any? {
        return [
            "__a": "1"
        ]
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) {
        let json = JSON(Object: object)
        if let user = json["user"].dictionaryObject {
            let realm = try! Realm()
            try! realm.write {
                realm.add(Mapper<IGBrand>().map(JSONObject: user)!, update: true)
            }
        }
    }
}
