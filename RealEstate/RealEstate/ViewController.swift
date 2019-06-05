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
    var popularProjectArray: Results<PopularProject>?
    var preSaleArray: Results<PreSale>?
    var countOfSection: Int = 0
    var notificationToken: NotificationToken? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Kanguroo"
        
        self.recommendationDataArray = AppUtility.sharedInstance.realmInstance.objects(Recommendation.self).sorted(byKeyPath: "id", ascending: true)
        self.topDeveloperDataArray = AppUtility.sharedInstance.realmInstance.objects(TopDeveloper.self).sorted(byKeyPath: "id", ascending: true)
        self.featuredLocalitiesDataArray = AppUtility.sharedInstance.realmInstance.objects(FeaturedLocalities.self).sorted(byKeyPath: "id", ascending: true)
        self.blogDataArray = AppUtility.sharedInstance.realmInstance.objects(Blog.self).sorted(byKeyPath: "id", ascending: true)
        self.popularProjectArray = AppUtility.sharedInstance.realmInstance.objects(PopularProject.self).sorted(byKeyPath: "id", ascending: true)
        self.preSaleArray = AppUtility.sharedInstance.realmInstance.objects(PreSale.self).sorted(byKeyPath: "id", ascending: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ReloadTableViewData), name: Notification.Name(REFRESHNOTIFICATION), object: nil)
        
        self.tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsets(top: -1, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = scrollView as? UITableView else {return}
        _ = tableView.indexPathsForVisibleRows!.map{ tableView.headerView(forSection: $0.section) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.sharedInstance.GetDataFromServer()
        AppUtility.sharedInstance.showLoadingHUD(to_view: self.view)
    }
    
    @objc func ReloadTableViewData()
    {
        self.tableView.reloadData()
        AppUtility.sharedInstance.hideLoadingHUD(for_view: self.view)
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
        if section == 0
        {
            if self.recommendationDataArray!.count > 0
            {
                return 2
            }
            else
            {
                return 0
            }
        }
        else if section == 1
        {
            if self.topDeveloperDataArray!.count > 0
            {
                return 2
            }
            else
            {
                return 0
            }
        }
        else if section == 2
        {
            if self.preSaleArray!.count > 0
            {
                return 2
            }
            else
            {
                return 0
            }
        }
        else if section == 3
        {
            if self.popularProjectArray!.count > 0
            {
                return 2
            }
            else
            {
                return 0
            }
        }
        else if section == 4
        {
            if self.featuredLocalitiesDataArray!.count > 0
            {
                return 2
            }
            else
            {
                return 0
            }
        }
        else if section == 5
        {
            if self.blogDataArray!.count > 0
            {
                return 2
            }
            else
            {
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print(indexPath.section, indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0
        {
            return 60
        }
        if indexPath.section == 0
        {
            if self.recommendationDataArray!.count > 0
            {
                return 285
            }
            else
            {
                return 1
            }
        }
        else if indexPath.section == 1
        {
            if self.topDeveloperDataArray!.count > 0
            {
                return 180
            }
            else
            {
                return 0
            }
        }
        else if indexPath.section == 2
        {
            if self.preSaleArray!.count > 0
            {
                return 180
            }
            else
            {
                return 0
            }
        }
        else if indexPath.section == 3
        {
            if self.popularProjectArray!.count > 0
            {
                return 200
            }
            else
            {
                return 0
            }
        }
        else if indexPath.section == 4
        {
            if self.featuredLocalitiesDataArray!.count > 0
            {
                return 80
            }
            else
            {
                return 0
            }
        }
        else if indexPath.section == 5
        {
            if self.blogDataArray!.count > 0
            {
                return 180
            }
            else
            {
                return 0
            }
        }
        return 0
    }
}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0
            {
                //HeaderTableViewCell was used for scrolable tableview section header.
                let cell : HeaderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
                cell.nameLabel.text = "Recommended"
                
                return cell
            }
            else
            {
                let cell : FirstTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
                
                cell.firstCollectionView.delegate = self
                cell.firstCollectionView.dataSource = self
                cell.firstCollectionView.tag = 1
                cell.firstCollectionView.reloadData()
                
                cell.selectionStyle = .none
                return cell
            }
            
        case 1:
            if indexPath.row == 0
            {
                let cell : HeaderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
                cell.nameLabel.text = "Top Developers"
                
                return cell
            }
            else
            {
                let cell : DeveloperTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell", for: indexPath) as! DeveloperTableViewCell
                
                cell.developerCollectionView.delegate = self
                cell.developerCollectionView.dataSource = self
                cell.developerCollectionView.tag = 2
                cell.developerCollectionView.reloadData()
                
                cell.selectionStyle = .none
                return cell
            }
            
        case 2:
            if indexPath.row == 0
            {
                let cell : HeaderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
                cell.nameLabel.text = "Pre-Sales"
                
                return cell
            }
            else
            {
                let cell : PreSaleTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "PreSaleTableViewCell", for: indexPath) as! PreSaleTableViewCell
                
                
                cell.preSaleCollectionView.delegate = self
                cell.preSaleCollectionView.dataSource = self
                cell.preSaleCollectionView.tag = 3
                cell.preSaleCollectionView.reloadData()
                
                cell.selectionStyle = .none
                return cell
            }
            
        case 3:
            if indexPath.row == 0
            {
                let cell : HeaderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
                cell.nameLabel.text = "Popular Projects"
                
                return cell
            }
            else
            {
                let cell : PopularTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "PopularTableViewCell", for: indexPath) as! PopularTableViewCell
                
                cell.popularCollectionView.delegate = self
                cell.popularCollectionView.dataSource = self
                cell.popularCollectionView.tag = 4
                cell.popularCollectionView.reloadData()
                
                cell.selectionStyle = .none
                return cell
            }
            
        case 4:
            if indexPath.row == 0
            {
                let cell : HeaderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
                cell.nameLabel.text = "Featured Localities"
                
                return cell
            }
            else
            {
                let cell : FeatureTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "FeatureTableViewCell", for: indexPath) as! FeatureTableViewCell
                
                cell.featureCollectionView.delegate = self
                cell.featureCollectionView.dataSource = self
                cell.featureCollectionView.tag = 5
                cell.featureCollectionView.reloadData()
                
                cell.selectionStyle = .none
                return cell
            }
        case 5:
            if indexPath.row == 0
            {
                let cell : HeaderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
                cell.nameLabel.text = "Our Blogs and Articles"
                
                return cell
            }
            else
            {
                let cell : BlogTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "BlogTableViewCell", for: indexPath) as! BlogTableViewCell
                
                cell.blogCollectionView.delegate = self
                cell.blogCollectionView.dataSource = self
                cell.blogCollectionView.tag = 6
                cell.blogCollectionView.reloadData()
                
                cell.selectionStyle = .none
                return cell
            }
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
            if (self.preSaleArray!.count > 0) {
                return preSaleArray!.count
            }
        }
        else if collectionView.tag == 4
        {
            if (self.popularProjectArray!.count > 0) {
                return popularProjectArray!.count
            }
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
                
                cell.siteImageView.af_setImage(withURLRequest: urlReq, placeholderImage: UIImage.init(named: "placeholder_Image"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: true, completion:
                    {
                        response in
                        if (response.result.isSuccess)
                        {
                            cell.siteImageView?.image =  response.result.value!
                        }
                        else
                        {
                            cell.siteImageView.image = UIImage.init(named: "placeholder_Image")
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
                
                cell.siteImageView.af_setImage(withURLRequest: urlReq, placeholderImage: UIImage.init(named: "placeholder_Image"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: true, completion:
                    {
                        response in
                        if (response.result.isSuccess)
                        {
                            cell.siteImageView?.image =  response.result.value!
                        }
                        else
                        {
                            cell.siteImageView.image = UIImage.init(named: "placeholder_Image")
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
            let preSale : PreSale  = self.preSaleArray![indexPath .row]
            
            cell.amountLabel.text = preSale.amount > 0 ? String(format:"$ %dK",preSale.amount) : ""
            cell.apartmentType.text = preSale.type
            cell.nameLabel.text = preSale.name
            
            let url = URL(string: (preSale.siteImageUrl))!
            print(url)
            let urlReq : URLRequest = URLRequest.init(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
            
            cell.siteImageView.af_setImage(withURLRequest: urlReq, placeholderImage: UIImage.init(named: "placeholder_Image"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: true, completion:
                {
                    response in
                    if (response.result.isSuccess)
                    {
                        cell.siteImageView?.image =  response.result.value!
                    }
                    else
                    {
                        cell.siteImageView.image = UIImage.init(named: "placeholder_Image")
                    }
            })
            
            return cell
        }
        else if collectionView.tag == 4
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as! PopularCollectionViewCell
            
            let popularProject : PopularProject  = self.popularProjectArray![indexPath .row]
            
            let url = URL(string: (popularProject.siteImageUrl))!
            print(url)
            let urlReq : URLRequest = URLRequest.init(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
            
            cell.siteImageView.af_setImage(withURLRequest: urlReq, placeholderImage: UIImage.init(named: "placeholder_Image"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: true, completion:
                {
                    response in
                    if (response.result.isSuccess)
                    {
                        cell.siteImageView?.image =  response.result.value!
                    }
                    else
                    {
                        cell.siteImageView.image = UIImage.init(named: "placeholder_Image")
                    }
            })
            
            cell.amountLabel.text = popularProject.amount > 0 ? String(format:"$ %dK",popularProject.amount) : ""
            cell.appartmentType.text = popularProject.type
            cell.developerLabel.text = popularProject.developerName
            cell.titleLabel.text = popularProject.title
            
            return cell
        }
        else if collectionView.tag == 5
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeatureCollectionViewCell", for: indexPath) as! FeatureCollectionViewCell
            let featuredLocalities : FeaturedLocalities  = self.featuredLocalitiesDataArray![indexPath .row]
                cell.featureLabel.text = featuredLocalities.name
                cell.totalCountLabel.text = String(format:"%d",featuredLocalities.projectCount)
                cell.areaLabel.text = String(format:"$ %d / sqft", featuredLocalities.price)
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlogCollectionViewCell", for: indexPath) as! BlogCollectionViewCell
            
            let topDeveloper : Blog  = self.blogDataArray![indexPath .row]
                let url = URL(string: (topDeveloper.siteImageUrl))!
                print(url)
                let urlReq : URLRequest = URLRequest.init(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60)
                
                cell.siteImageView.af_setImage(withURLRequest: urlReq, placeholderImage: UIImage.init(named: "placeholder_Image"), filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .noTransition, runImageTransitionIfCached: true, completion:
                    {
                        response in
                        if (response.result.isSuccess)
                        {
                            cell.siteImageView?.image =  response.result.value!
                        }
                        else
                        {
                            cell.siteImageView.image = UIImage.init(named: "placeholder_Image")
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


