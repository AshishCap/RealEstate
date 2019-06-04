//
//  AppDelegate.swift
//  RealEstate
//
//  Created by ashish on 6/4/19.
//  Copyright © 2019 Technical. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        WebService.GetDataFromServer(completionHandler: {(responseObject, error) in
//            print(responseObject)
//            print("responseObject -> \(responseObject)")
            
            if let statusCode = responseObject["success"] as? String {
                if (statusCode == "1")
                {
                    if let dic = responseObject["data"] as? NSDictionary
                    {
                        if let recommendedArray: NSArray = dic.value(forKey: "recommended") as? NSArray
                        {
                            //print(recommendedArray)
                            let recommendationListArr = AppUtility.sharedInstance.realmInstance.objects(Recommendation.self)
                            
                            if recommendationListArr != nil && recommendationListArr.count > 0
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
                                print(dic1.value(forKey: "id") as? Int ?? 0)
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
                            
                            if topDeveloperListArr != nil && topDeveloperListArr.count > 0
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
                        if let pre_sale: NSArray = dic.value(forKey: "pre_sale") as? NSArray
                        {
                            print(pre_sale.count)
                        }
                        if let popular_projects: NSArray = dic.value(forKey: "popular_projects") as? NSArray
                        {
                            print(popular_projects.count)
                        }
                        if let featured_localities: NSArray = dic.value(forKey: "featured_localities") as? NSArray
                        {
                            let topDeveloperListArr = AppUtility.sharedInstance.realmInstance.objects(FeaturedLocalities.self)
                            
                            if topDeveloperListArr != nil && topDeveloperListArr.count > 0
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
                            
                            if topDeveloperListArr != nil && topDeveloperListArr.count > 0
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
            }
            //recommended
            //top_developers
            //pre_sale
            //popular_projects
            //featured_localities
            //blogs
            
        })
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

