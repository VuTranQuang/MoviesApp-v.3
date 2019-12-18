//
//  Popular.swift
//  MoviesApp v.3
//
//  Created by VuTQ10 on 12/18/19.
//  Copyright © 2019 VuTQ10. All rights reserved.
//

import UIKit
typealias JSON = Dictionary<AnyHashable, Any>

class Popular {
    var results = [Results]()
    init(dict: JSON) {
        let resultsData = dict["results"] as? [JSON] ?? []
        resultsData.forEach { item in
            results.append(Results(dict: item))
        }
    }
}

class Results {
    var rating: Double?
    var title: String?
    var adult: Bool?
    var overview: String?
    var release: String?
    var dropPath: String?
    var id: Int?
    
    init(dict: JSON) {
        rating = dict["vote_average"] as? Double
        title = dict["title"] as? String
        adult = dict["adult"] as? Bool
        overview = dict["overview"] as? String
        release = dict["release_date"] as? String
        dropPath = dict["backdrop_path"] as? String
        id = dict["id"] as? Int
    }
}
