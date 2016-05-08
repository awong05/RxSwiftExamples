//
//  Repository.swift
//  RxAlamofireExample
//
//  Created by Andy Wong on 5/7/16.
//  Copyright © 2016 Propel Marketing. All rights reserved.
//

import ObjectMapper

class Repository: Mappable {
    var identifier: Int!
    var language: String!
    var url: String!
    var name: String!

    required init?(_ map: Map) {}

    func mapping(map: Map) {
        identifier <- map["id"]
        language <- map["language"]
        url <- map["url"]
        name <- map["name"]
    }
}
