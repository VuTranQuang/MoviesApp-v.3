//
//  VerticalCollectionCell.swift
//  MoviesApp v.3
//
//  Created by VuTQ10 on 12/17/19.
//  Copyright © 2019 VuTQ10. All rights reserved.
//

import UIKit

class VerticalCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func bindingData(items: Results, configuration: Images) {
        titleMovie.text = items.title
        
        // Load Image from URL
        guard let dropSize = configuration.dropSize else { return }
        guard let secureURL = configuration.secureUrl else { return }
        var dropPath: String!
        if items.dropPath == nil {
            dropPath = items.posterPath
        } else {
            dropPath = items.dropPath
        }
        self.imageMovie.load(url: HorizontalCollectionCell.fillImageURL(baseURL: secureURL, backdropSize: dropSize[0], dropPath: dropPath))
    }
    override func prepareForReuse() {
        titleMovie.text = ""
        imageMovie.image = UIImage()
    }

}
