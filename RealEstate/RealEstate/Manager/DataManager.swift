//
//  DataManager.swift
//  RealEstate
//
//  Created by ashish on 6/5/19.
//  Copyright © 2019 Technical. All rights reserved.
//

import UIKit

class DataManager: NSObject
{
    /*--------- initiate shared manager   ------------*/
    class var sharedInstance: DataManager
    {
        struct Static
        {
            static let instance : DataManager = DataManager()
            
        }
        return Static.instance
    }
    
    func GetDataFromServer()
    {
        WebService.GetDataFromServer(completionHandler: {(responseObject, error) in
            
            if let statusCode = responseObject["success"] as? String {
                if (statusCode == "1")
                {
                    if let dic = responseObject["data"] as? NSDictionary
                    {
                        if let recommendedArray: NSArray = dic.value(forKey: "recommended") as? NSArray
                        {
                            let recommendationListArr = AppUtility.sharedInstance.realmInstance.objects(Recommendation.self)
                            
                            if recommendationListArr.count > 0
                            {
                                for recommendation in recommendationListArr {
                                    try! AppUtility.sharedInstance.realmInstance.write {
                                        AppUtility.sharedInstance.realmInstance.delete(recommendation)
                                    }
                                }
                            }
                            
                            for recommended in recommendedArray
                            {
                                let dic1 : NSDictionary =  recommended as! NSDictionary
                                let recommendation = Recommendation()
                                recommendation.siteImageUrl = dic1.value(forKey: "image") as? String ?? ""
                                recommendation.id = dic1.value(forKey: "id") as? Int ?? 0
                                
                                if let configurationDic: NSDictionary = dic1["configuration"] as? NSDictionary
                                {
                                    if let str = configurationDic.value(forKey: "name_en") as? String
                                    {
                                        if !str.isEmpty
                                        {
                                            if let property_typeDic: NSDictionary = dic1["property_type"] as? NSDictionary
                                            {
                                                if let str2 = property_typeDic.value(forKey: "name_en") as? String
                                                {
                                                    if !str2.isEmpty
                                                    {
                                                        recommendation.name = String(format:"%@ %@", str, str2)
                                                    }
                                                    else
                                                    {
                                                        recommendation.name = str
                                                    }
                                                }
                                                else
                                                {
                                                    recommendation.name = str
                                                }
                                            }
                                        }
                                        else
                                        {
                                            if let property_typeDic: NSDictionary = dic1["property_type"] as? NSDictionary
                                            {
                                                if let str2 = property_typeDic.value(forKey: "name_en") as? String
                                                {
                                                    if !str2.isEmpty
                                                    {
                                                        recommendation.name = str2
                                                    }
                                                    else
                                                    {
                                                        recommendation.name = ""
                                                    }
                                                }
                                                else
                                                {
                                                    recommendation.name = ""
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                if let buildingDic: NSDictionary = dic1["building"] as? NSDictionary
                                {
                                    recommendation.address = buildingDic.value(forKey: "address") as? String ?? ""
                                    recommendation.buildingName = buildingDic.value(forKey: "name") as? String ?? ""
                                    if let developerDic: NSDictionary = buildingDic["developer"] as? NSDictionary
                                    {
                                        recommendation.developerName = developerDic.value(forKey: "name") as? String ?? ""
                                    }
                                }
                                
                                recommendation.price = dic1.value(forKey: "max_price") as? Int ?? 0
                                
                                do
                                {
                                    try AppUtility.sharedInstance.realmInstance.write { () -> Void in
                                        AppUtility.sharedInstance.realmInstance.add(recommendation)
                                    }
                                }
                                catch let err as NSError {
                                    print("Realm data error -> \(err.debugDescription)")
                                }
                            }
                        }
                        if let top_developersArray: NSArray = dic.value(forKey: "top_developers") as? NSArray
                        {
                            let topDeveloperListArr = AppUtility.sharedInstance.realmInstance.objects(TopDeveloper.self)
                            
                            if topDeveloperListArr.count > 0
                            {
                                for topDeveloper in topDeveloperListArr {
                                    try! AppUtility.sharedInstance.realmInstance.write {
                                        AppUtility.sharedInstance.realmInstance.delete(topDeveloper)
                                    }
                                }
                            }
                            
                            for top_developer in top_developersArray
                            {
                                let dic1 : NSDictionary =  top_developer as! NSDictionary
                                let topDeveloper = TopDeveloper()
                                topDeveloper.id = dic1.value(forKey: "id") as? Int ?? 0
                                topDeveloper.name = dic1.value(forKey: "name") as? String ?? ""
                                topDeveloper.developer_desc = dic1.value(forKey: "developer_desc") as? String ?? ""
                                topDeveloper.projectCount = dic1.value(forKey: "total_properties_count") as? Int ?? 0
                                topDeveloper.siteImageUrl = dic1.value(forKey: "developer_image") as? String ?? ""
                                
                                do
                                {
                                    try AppUtility.sharedInstance.realmInstance.write { () -> Void in
                                        AppUtility.sharedInstance.realmInstance.add(topDeveloper)
                                    }
                                }
                                catch let err as NSError {
                                    print("Realm data error -> \(err.debugDescription)")
                                }
                            }
                        }
                        if let pre_saleArray: NSArray = dic.value(forKey: "pre_sale") as? NSArray
                        {
                            let preSaleListArr = AppUtility.sharedInstance.realmInstance.objects(PreSale.self)
                            
                            if preSaleListArr.count > 0
                            {
                                for preSaleList in preSaleListArr {
                                    try! AppUtility.sharedInstance.realmInstance.write {
                                        AppUtility.sharedInstance.realmInstance.delete(preSaleList)
                                    }
                                }
                            }
                            
                            for pre_sale in pre_saleArray
                            {
                                let dic1 : NSDictionary =  pre_sale as! NSDictionary
                                let preSale = PreSale()
                                preSale.id = dic1.value(forKey: "id") as? Int ?? 0
                                preSale.name = dic1.value(forKey: "name") as? String ?? ""
                                if let configurations: NSArray = dic1.value(forKey: "configurations") as? NSArray
                                {
                                    for config in configurations
                                    {
                                        let dict2: NSDictionary = config as! NSDictionary
                                        if preSale.type.isEmpty
                                        {
                                            preSale.type = dict2.value(forKey: "name") as? String ?? ""
                                        }
                                        else
                                        {
                                            preSale.type = String(format:"%@/%@",preSale.type, dict2.value(forKey: "name") as? String ?? "")
                                        }
                                        
                                        if preSale.amount > 0
                                        {
                                            preSale.amount = dict2.value(forKey: "base_price") as? Int ?? 0
                                        }
                                        else
                                        {
                                            let basePrice: Int = dict2.value(forKey: "base_price") as? Int ?? 0
                                            preSale.amount = preSale.amount + basePrice
                                        }
                                    }
                                }
                                preSale.siteImageUrl = dic1.value(forKey: "main_image") as? String ?? ""
                                do
                                {
                                    try AppUtility.sharedInstance.realmInstance.write { () -> Void in
                                        AppUtility.sharedInstance.realmInstance.add(preSale)
                                    }
                                }
                                catch let err as NSError {
                                    print("Realm data error -> \(err.debugDescription)")
                                }
                            }
                        }
                        if let popular_projectsArray: NSArray = dic.value(forKey: "popular_projects") as? NSArray
                        {
                            let preSaleListArr = AppUtility.sharedInstance.realmInstance.objects(PopularProject.self)
                            
                            if preSaleListArr.count > 0
                            {
                                for preSaleList in preSaleListArr {
                                    try! AppUtility.sharedInstance.realmInstance.write {
                                        AppUtility.sharedInstance.realmInstance.delete(preSaleList)
                                    }
                                }
                            }
                            
                            for popular_projects in popular_projectsArray
                            {
                                let dic1 : NSDictionary =  popular_projects as! NSDictionary
                                let popularProject = PopularProject()
                                popularProject.id = dic1.value(forKey: "id") as? Int ?? 0
                                popularProject.title = dic1.value(forKey: "name") as? String ?? ""
                                if let developerDic: NSDictionary = dic1["developer"] as? NSDictionary
                                {
                                    popularProject.developerName = developerDic.value(forKey: "name") as? String ?? ""
                                }
                                if let configurations: NSArray = dic1.value(forKey: "configurations") as? NSArray
                                {
                                    for config in configurations
                                    {
                                        let dict2: NSDictionary = config as! NSDictionary
                                        if popularProject.type.isEmpty
                                        {
                                            popularProject.type = dict2.value(forKey: "name") as? String ?? ""
                                        }
                                        else
                                        {
                                            popularProject.type = String(format:"%@/%@",popularProject.type, dict2.value(forKey: "name") as? String ?? "")
                                        }
                                        
                                        if popularProject.amount > 0
                                        {
                                            popularProject.amount = dict2.value(forKey: "base_price") as? Int ?? 0
                                        }
                                        else
                                        {
                                            let basePrice: Int = dict2.value(forKey: "base_price") as? Int ?? 0
                                            popularProject.amount = popularProject.amount + basePrice
                                        }
                                    }
                                }
                                popularProject.siteImageUrl = dic1.value(forKey: "main_image") as? String ?? ""
                                do
                                {
                                    try AppUtility.sharedInstance.realmInstance.write { () -> Void in
                                        AppUtility.sharedInstance.realmInstance.add(popularProject)
                                    }
                                }
                                catch let err as NSError {
                                    print("Realm data error -> \(err.debugDescription)")
                                }
                            }
                        }
                        if let featured_localities: NSArray = dic.value(forKey: "featured_localities") as? NSArray
                        {
                            let topDeveloperListArr = AppUtility.sharedInstance.realmInstance.objects(FeaturedLocalities.self)
                            
                            if topDeveloperListArr.count > 0
                            {
                                for topDeveloper in topDeveloperListArr {
                                    try! AppUtility.sharedInstance.realmInstance.write {
                                        AppUtility.sharedInstance.realmInstance.delete(topDeveloper)
                                    }
                                }
                            }
                            
                            for featuredlocality in featured_localities
                            {
                                let dic1 : NSDictionary =  featuredlocality as! NSDictionary
                                let locality = FeaturedLocalities()
                                locality.id = dic1.value(forKey: "id") as? Int ?? 0
                                locality.name = dic1.value(forKey: "name_en") as? String ?? ""
                                locality.projectCount = dic1.value(forKey: "buildings_count") as? Int ?? 0
                                locality.price = dic1.value(forKey: "price_per_sqft") as? Int ?? 0
                                
                                do
                                {
                                    try AppUtility.sharedInstance.realmInstance.write { () -> Void in
                                        AppUtility.sharedInstance.realmInstance.add(locality)
                                    }
                                }
                                catch let err as NSError {
                                    print("Realm data error -> \(err.debugDescription)")
                                }
                            }
                        }
                        if let blogs: NSArray = dic.value(forKey: "blogs") as? NSArray
                        {
                            let topDeveloperListArr = AppUtility.sharedInstance.realmInstance.objects(Blog.self)
                            
                            if topDeveloperListArr.count > 0
                            {
                                for topDeveloper in topDeveloperListArr {
                                    try! AppUtility.sharedInstance.realmInstance.write {
                                        AppUtility.sharedInstance.realmInstance.delete(topDeveloper)
                                    }
                                }
                            }
                            
                            for featuredlocality in blogs
                            {
                                let dic1 : NSDictionary =  featuredlocality as! NSDictionary
                                let blog = Blog()
                                blog.id = dic1.value(forKey: "id") as? Int ?? 0
                                blog.siteImageUrl = dic1.value(forKey: "image") as? String ?? ""
                                blog.name = dic1.value(forKey: "title_en") as? String ?? ""
                                blog.date = dic1.value(forKey: "created_at") as? String ?? ""
                                
                                do
                                {
                                    try AppUtility.sharedInstance.realmInstance.write { () -> Void in
                                        AppUtility.sharedInstance.realmInstance.add(blog)
                                    }
                                }
                                catch let err as NSError {
                                    print("Realm data error -> \(err.debugDescription)")
                                }
                            }
                        }
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: REFRESHNOTIFICATION), object: nil, userInfo: nil)
                    }
                }
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: REFRESHNOTIFICATION), object: nil, userInfo: nil)
            }
        })
    }
}
