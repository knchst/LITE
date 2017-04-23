//
//  TopicRequest.swift
//  LITE
//
//  Created by Kenichi Saito on 4/22/17.
//  Copyright © 2017 Kenichi Saito. All rights reserved.
//

import Foundation
import APIKit
import ObjectMapper
import RealmSwift
import SwiftyJSON

struct TopicRequest: Request {
    var baseURL: URL { return URL(string: "https://fuk-roo.com/api/v2")! }
    var method: HTTPMethod { return .get }
    var path: String { return "/categories/14" }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) {
        let json = JSON(Object: object)
        if let category = json["category"].dictionary {
            if let articles = category["articles"]?.arrayObject {
                let realm = try! Realm()
                try! realm.write { realm.add(Mapper<Topic>().mapArray(JSONObject: articles)!, update: true) }
            }
        }
    }
}
