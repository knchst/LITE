//
//  IGBrandMedia.swift
//  LITE
//
//  Created by Kenichi Saito on 9/3/17.
//  Copyright © 2017 Kenichi Saito. All rights reserved.
//

import RealmSwift
import ObjectMapper

class IGBrandMedia: Object, Mappable {
    dynamic var id = String()
    dynamic var likes = Int()
    dynamic var comments = Int()
    dynamic var code = String()
    dynamic var isVideo = Bool()
    dynamic var src = String()
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        likes <- map["likes.count"]
        comments <- map["comments.count"]
        code <- map["code"]
        isVideo <- map["is_video"]
        src <- map["thumbnail_src"]
    }
}
