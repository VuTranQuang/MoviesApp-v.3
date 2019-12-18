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
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(UINib(nibName: "HorizontalCollectionCell", bundle: nil), forCellWithReuseIdentifier: "horizontal")
    }
    

}

extension PopularCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "horizontal", for: indexPath) as! HorizontalCollectionCell
        return cell
    }
    
    
}

extension PopularCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.width / 3)
    }
}
