//
//  TopicArticleRequest.swift
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

struct TopicArticleRequest: Request {
    var topicId: String!
    
    var baseURL: URL { return URL(string: "https://fuk-roo.com/api/v1")! }
    var method: HTTPMethod { return .get }
    var path: String { return "/users/" + topicId }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) {
        let json = JSON(Object: object)
        if let user = json["user"].dictionary {
            if let hooks = user["hooks"]?.array {
                let realm = try! Realm()
                for hook in hooks {
                    if let article = hook["article"].dictionaryObject {
                        try! realm.write { realm.add(Mapper<Article>().map(JSONObject: article)!, update: true) }
                    }
                }
            }
        }
    }
}
