//
//  ViewController.swift
//  RealEstate
//
//  Created by ashish on 6/4/19.
//  Copyright © 2019 Technical. All rights reserved.
//

import UIKit
import RealmSwift
import AlamofireImage

class ViewController: UIViewController
{
    @IBOutlet var tableView: UITableView!
    var recommendationDataArray: Results<Recommendation>?
    var topDeveloperDataArray: Results<TopDeveloper>?
    var featuredLocalitiesDataArray: Results<FeaturedLocalities>?
    var blogDataArray: Results<Blog>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.recommendationDataArray = AppUtility.sharedInstance.realmInstance.objects(Recommendation.self).sorted(byKeyPath: "id", ascending: true)
        self.topDeveloperDataArray = AppUtility.sharedInstance.realmInstance.objects(TopDeveloper.self).sorted(byKeyPath: "id", ascending: true)
        self.featuredLocalitiesDataArray = AppUtility.sharedInstance.realmInstance.objects(FeaturedLocalities.self).sorted(byKeyPath: "id", ascending: true)
        self.blogDataArray = AppUtility.sharedInstance.realmInstance.objects(Blog.self).sorted(byKeyPath: "id", ascending: true)
        NotificationCenter.default.addObserver(self, selector: #selector(ReloadTableViewData), name: Notification.Name(REFRESHNOTIFICATION), object: nil)
        
        self.tableView.tableFooterView = UIView()
    }
    
    @objc func ReloadTableViewData()
    {
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print(indexPath.section, indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0
        {
            return 270
        }
        else if indexPath.section == 1
        {
            return 180
        }
        else if indexPath.section == 2
        {
            return 160
        }
        else if indexPath.section == 3
        {
            return 200
        }
        else if indexPath.section == 4
        {
            return 80
        }
        else if indexPath.section == 5
        {
            return 180
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        var view = UIView()
        view = UIView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
        var groupName_label = UILabel()
        groupName_label = UILabel.init(frame: CGRect(x: 20, y: 0, width: view.frame.size.width - 90, height: 45))
        groupName_label.font = UIFont.init(name: "verdana-Bold", size: 20)
        groupName_label.textColor = .black
        groupName_label.textAlignment = .left
        
        if section == 0
        {
            groupName_label.text = "Recommended"
        }
        else if section == 1
        {
            groupName_label.text = "Top Developers"
        }
        else if section == 2
        {
            groupName_label.text = "Pre-Sales"
        }
        else if section == 3
        {
            groupName_label.text = "Popular Projects"
        }
        else if section == 4
        {
            groupName_label.text = "Featured Localities"
        }
        else if section == 5
        {
            groupName_label.text = "Our Blogs and Articles"
        }
        view.addSubview(groupName_label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 60
    }
}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section {
        case 0:
            let cell : FirstTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            
            cell.firstCollectionView.delegate = self
            cell.firstCollectionView.dataSource = self
            cell.firstCollectionView.tag = 1
            
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell : DeveloperTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell", for: indexPath) as! DeveloperTableViewCell
            
            cell.developerCollectionView.delegate = self
            cell.developerCollectionView.dataSource = self
            cell.developerCollectionView.tag = 2
            
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell : PreSaleTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "PreSaleTableViewCell", for: indexPath) as! PreSaleTableViewCell
            
            cell.preSaleCollectionView.delegate = self
            cell.preSaleCollectionView.dataSource = self
            cell.preSaleCollectionView.tag = 3
            
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell : PopularTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
            
            cell.popularCollectionView.delegate = self
            cell.popularCollectionView.dataSource = self
            cell.popularCollectionView.tag = 4
            
            cell.selectionStyle = .none
            return cell
        case 4:
            let cell : FeatureTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell", for: indexPath) as! FeatureTableViewCell
            
            cell.featureCollectionView.delegate = self
            cell.featureCollectionView.dataSource = self
            cell.featureCollectionView.tag = 5
            
            cell.selectionStyle = .none
            return cell
        case 5:
            let cell : BlogTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "BlogTableViewCell", for: indexPath) as! BlogTableViewCell
            
            cell.blogCollectionView.delegate = self
            cell.blogCollectionView.dataSource = self
            cell.blogCollectionView.tag = 6
            
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ViewController: UICollectionViewDelegate
{
}

extension ViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView.tag == 1
        {
            if (self.recommendationDataArray!.count > 0) {
                return recommendationDataArray!.count
            }
        }
        else if collectionView.tag == 2
        {
            if (self.topDeveloperDataArray!.count > 0) {
                return topDeveloperDataArray!.count
            }
        }
        else if collectionView.tag == 3
        {
            return 4
        }
        else if collectionView.tag == 4
        {
            return 5
        }
        else if collectionView.tag == 5
        {
            if (self.featuredLocalitiesDataArray!.count > 0) {
                return featuredLocalitiesDataArray!.count
            }
        }
        else if collectionView.tag == 6
        {
            if (self.blogDataArray!.count > 0) {
                return blogDataArray!.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView.tag == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCollectionViewCell", for: indexPath) as! FirstCollectionViewCell
            let recommendation : Recommendation  = self.recommendationDataArray![indexPath .row]
                cell.amountLabel.text = String(format:"$ %d", recommendation.price)
                cell.descriptionLabel.text = recommendation.buildingName
                cell.locationLabel.text = recommendation.address
                cell.titleLabel.text = recommendation.name
                cell.userLabel.text = recommendation.developerName
                
                let url = URL(string: (recommendation.siteImageUrl))!
                let urlReq : URLRequest = URLRequest.init(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
                
                cell.siteImageView.af_setImage(withURLRequest: urlReq, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: true, completion:
                    {
                        response in
                        if (response.result.isSuccess)
                        {
                            cell.siteImageView?.image =  response.result.value!
                        }
                })
            
            cell.siteImageView.backgroundColor = UIColor.red
            
            return cell
        }
        else if collectionView.tag == 2
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DeveloperCollectionViewCell", for: indexPath) as! DeveloperCollectionViewCell
            
            let topDeveloper : TopDeveloper  = self.topDeveloperDataArray![indexPath .row]
                let url = URL(string: (topDeveloper.siteImageUrl))!
                print(url)
                let urlReq : URLRequest = URLRequest.init(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
                
                cell.siteImageView.af_setImage(withURLRequest: urlReq, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: true, completion:
                    {
                        response in
                        if (response.result.isSuccess)
                        {
                            cell.siteImageView?.image =  response.result.value!
                        }
                })
                
                cell.projectCountLabel.text = String(format:"%d", topDeveloper.projectCount)
                cell.developerName.text = topDeveloper.name
                cell.developerDescription.text = topDeveloper.developer_desc
            
            return cell
        }
        else if collectionView.tag == 3
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PreSaleCollectionViewCell", for: indexPath) as! PreSaleCollectionViewCell
            
            cell.siteImageView.backgroundColor = UIColor.red
            
            return cell
        }
        else if collectionView.tag == 4
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
            
            cell.siteImageView.backgroundColor = UIColor.red
            
            return cell
        }
        else if collectionView.tag == 5
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCollectionViewCell", for: indexPath) as! FeatureCollectionViewCell
            let featuredLocalities : FeaturedLocalities  = self.featuredLocalitiesDataArray![indexPath .row]
                cell.featureLabel.text = featuredLocalities.name
                cell.totalCountLabel.text = String(format:"%d",featuredLocalities.projectCount)
                cell.areaLabel.text = String(format:"$ %d / sqft", featuredLocalities.price)
            
            //cell.siteImageView.backgroundColor = UIColor.red
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlogCollectionViewCell", for: indexPath) as! BlogCollectionViewCell
            
            let topDeveloper : Blog  = self.blogDataArray![indexPath .row]
                let url = URL(string: (topDeveloper.siteImageUrl))!
                print(url)
                let urlReq : URLRequest = URLRequest.init(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
                
                cell.siteImageView.af_setImage(withURLRequest: urlReq, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: true, completion:
                    {
                        response in
                        if (response.result.isSuccess)
                        {
                            cell.siteImageView?.image =  response.result.value!
                        }
                })
                
                cell.dateLabel.text = topDeveloper.date
                cell.nameLabel.text = topDeveloper.name
            
            return cell
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        return CGSize(width: 200, height: 250 )
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
//    {
//        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
//    }
    
}


