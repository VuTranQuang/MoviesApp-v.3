//
//  ViewController.swift
//  MoviesApp v.3
//
//  Created by VuTQ10 on 12/17/19.
//  Copyright © 2019 VuTQ10. All rights reserved.
//

import UIKit
struct NibName {
    let horizontal: String?
    let vertical: String?
}

class PopularCollectionView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    
    
    let reFresh = UIRefreshControl()
    var isGrib = false {
        didSet {
            collectionView.reloadData()
        }
    }
    var pageNumber = 1
    var listResults = [Results]()
    var images = [Images]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Refresh Control
        collectionView.refreshControl = reFresh
        reFresh.tintColor = .blue
        reFresh.addTarget(self, action: #selector(reFreshData), for: .valueChanged)
        
        
        // Call Data from API
        APIService.callAPI(withAPIName: .configuration, method: .get, success: { json in
            let configuration = BaseURL(dict: json)
            // lưu Data base
            self.images = configuration.images
            APIService.callAPI(withAPIName: .popular, movieId: nil, method: .get, param: ["page": self.pageNumber], success: { jsonData in
                let model = Popular(dict: jsonData)
                self.listResults = model.results
                self.collectionView.reloadData()
            }, failure: { error in
                print(error)
            })
        }, failure: { error in
        })
        self.collectionView.reloadData()
        
        self.collectionView.register(UINib(nibName: "HorizontalCollectionCell", bundle: nil), forCellWithReuseIdentifier: "horizontal")
        self.collectionView.register(UINib(nibName: "VerticalCollectionCell", bundle: nil), forCellWithReuseIdentifier: "vertical")
    }

    @objc func reFreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.listResults = [self.listResults.removeFirst()]
            self.reFresh.endRefreshing()
            self.pageNumber = 1
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func onClickEdit(_ sender: UIBarButtonItem) {
        isGrib = !isGrib
    }
    @IBAction func openInfo(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: Notification.Name("isMenuShow"), object: nil)
    }
    
    
}

extension PopularCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moviesList = listResults[indexPath.row]
        if isGrib {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "vertical", for: indexPath) as! VerticalCollectionCell
            cell.bindingData(items: moviesList, configuration: images[0])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontal", for: indexPath) as! HorizontalCollectionCell
            cell.bindingData(item: moviesList, configuration: images[0])
            if moviesList.adult == false {
                cell.adult.isHidden = true
            } else {
                cell.adult.isHidden = false
                cell.adult.text = "18+"
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = listResults.count - 1
        if indexPath.item == lastItem {
            loadMore()
        }
    }
    
    func loadMore() {
        var newItem = [Results]()
        pageNumber += 1
        APIService.callAPI(withAPIName: .configuration, method: .get, success: { json in
            let configuration = BaseURL(dict: json)
            // lưu Data base
            self.images = configuration.images
            APIService.callAPI(withAPIName: .popular, movieId: nil, method: .get, param: ["page": self.pageNumber], success: { jsonData in
                let model = Popular(dict: jsonData)
                newItem = model.results
                newItem.forEach({ item in
                    self.listResults.append(item)
                })
                self.collectionView.reloadData()
            }, failure: { error in
                print(error)
            })
        }, failure: { error in
        })
        
    }
    
}

extension PopularCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isGrib {
            return CGSize(width: (collectionView.frame.width/2) - 5 , height: (collectionView.frame.width/2) - 2)
        } else {
            return CGSize(width: view.frame.width, height: view.frame.width / 3)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if isGrib {
            return 8
        }
        return 5
    }
    
}
