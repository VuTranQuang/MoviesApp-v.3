//
//  BaseURL.swift
//  MoviesApp v.3
//
//  Created by VuTQ10 on 12/18/19.
//  Copyright © 2019 VuTQ10. All rights reserved.
//

import UIKit

class BaseURL {
    var images = [Images]()
    init(dict: JSON) {
        guard let imagesData = dict["images"] as? JSON else { return }
            images.append(Images(dict: imagesData))
    
    }
}

struct Images {
    var secureUrl: String?
    var dropSize: [String]?
    var logoSize: [String]?
    var posterSize: [String]?
    init(dict: JSON) {
        secureUrl = dict["secure_base_url"] as? String
        dropSize = dict["backdrop_sizes"] as? [String]
        logoSize = dict["logo_sizes"] as? [String]
        posterSize = dict["poster_sizes"] as? [String]
    }
}
