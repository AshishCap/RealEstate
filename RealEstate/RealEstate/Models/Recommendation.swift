//
//  Recommendation.swift
//  RealEstate
//
//  Created by ashish on 6/4/19.
//  Copyright © 2019 Technical. All rights reserved.
//

import UIKit
import RealmSwift

class Recommendation: Object
{
    @objc dynamic var siteImageUrl: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var developerName: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var buildingName: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}

class TopDeveloper: Object
{
    @objc dynamic var siteImageUrl: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var developer_desc: String = ""
    @objc dynamic var projectCount: Int = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}

class PreSale: Object
{
    @objc dynamic var id: Int = 0
    @objc dynamic var siteImageUrl: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var amount: Int = 0
    @objc dynamic var type: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}

class PopularProject: Object
{
    @objc dynamic var id: Int = 0
    @objc dynamic var siteImageUrl: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var developerName: String = ""
    @objc dynamic var amount: Int = 0
    @objc dynamic var type: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}

class FeaturedLocalities: Object
{
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var projectCount: Int = 0
    override static func primaryKey() -> String? {
        return "id"
    }
}

class Blog: Object
{
    @objc dynamic var id: Int = 0
    @objc dynamic var siteImageUrl: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var date: String = ""
    override static func primaryKey() -> String? {
        return "id"
    }
}
