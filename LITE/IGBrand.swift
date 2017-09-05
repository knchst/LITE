//
//  IGBrand.swift
//  LITE
//
//  Created by Kenichi Saito on 9/3/17.
//  Copyright © 2017 Kenichi Saito. All rights reserved.
//

import RealmSwift
import ObjectMapper

class IGBrand: Object, Mappable {
    dynamic var id = String()
    dynamic var biography = String()
    dynamic var followedBy = Int()
    dynamic var follows = Int()
    dynamic var fullName = String()
    dynamic var profilePicUrlHd = String()
    dynamic var username = String()
    var medias = List<IGBrandMedia>()
    
    override static func primaryKey() -> String {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        biography <- map["biography"]
        followedBy <- map["followed_by.count", nested: true]
        follows <- map["follows.count", nested: true]
        fullName <- map["full_name"]
        username <- map["username"]
        profilePicUrlHd <- map["profile_pic_url_hd"]
        medias <- (map["media.nodes", nested: true], ArrayTransform<IGBrandMedia>())
    }
}
