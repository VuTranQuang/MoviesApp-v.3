//
//  HorizontalCollectionCell.swift
//  MoviesApp v.3
//
//  Created by VuTQ10 on 12/17/19.
//  Copyright © 2019 VuTQ10. All rights reserved.
//

import UIKit

class HorizontalCollectionCell: UICollectionViewCell {
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var adult: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
   class func fillImageURL(baseURL: String, backdropSize: String, dropPath: String) -> URL {
        let imageURL = baseURL + backdropSize + dropPath
        guard let url = URL(string: imageURL) else {
            return URL(string: "https://www.google.com/")!
        }
        return url
    }
    func bindingData(item: Results, configuration: Images) {
        titleMovie.text = item.title
        releaseDate.text = item.release
        rating.text = String(item.rating ?? 0)
        overview.text = item.overview
        adult.text = String(item.adult ?? false)
        
        // Load Image from URL
        guard let dropSize = configuration.dropSize else { return }
        guard let secureURL = configuration.secureUrl else { return }
        var dropPath: String!
        if item.dropPath == nil {
            dropPath = item.posterPath
        } else {
            dropPath = item.dropPath
        }
        self.imageMovie.load(url: HorizontalCollectionCell.fillImageURL(baseURL: secureURL, backdropSize: dropSize[0], dropPath: dropPath))
    }
    
    override func prepareForReuse() {
        titleMovie.text = ""
        releaseDate.text = ""
        rating.text = ""
        overview.text = ""
        adult.text = ""
        imageMovie.image = UIImage()
    }
    @IBAction func favoriteButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            [weak self]  in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
