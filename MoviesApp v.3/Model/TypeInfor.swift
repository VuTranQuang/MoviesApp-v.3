//
//  TypeInfor.swift
//  MoviesApp v.3
//
//  Created by VuTQ10 on 12/19/19.
//  Copyright © 2019 VuTQ10. All rights reserved.
//

import Foundation
import UIKit

struct TypeInfor {
    var image: UIImage
    var name: String
    var date: String
    var email: String
    var sex: String
    init(image: UIImage, name: String, date: String, email: String, sex: String) {
        self.image = image
        self.name = name
        self.date = date
        self.email = email
        self.sex = sex
    }
}
