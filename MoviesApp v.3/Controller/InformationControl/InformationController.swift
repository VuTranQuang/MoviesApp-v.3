//
//  InformationController.swift
//  MoviesApp v.3
//
//  Created by VuTQ10 on 12/19/19.
//  Copyright © 2019 VuTQ10. All rights reserved.
//

import UIKit

class InformationController: UIViewController {

    @IBOutlet weak var avataUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var birthDayUser: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    @IBOutlet weak var sexUser: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func fetchObject() {
        if let data = try? AppDelegate.context.fetch(Information.fetchRequest()) as [Information] {
            data.forEach { value in
                avataUser.image = value.imageUser as? UIImage
                nameUser.text = value.nameUser
                birthDayUser.text = value.birthDay
                emailUser.text = value.email
                sexUser.text = value.sex
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchObject()
    }
//    var item: TypeInfor? {
//        didSet {
//            item?.image = avataUser.image ?? UIImage()
//            item?.name = nameUser.text ?? ""
//            item?.date = birthDayUser.text ?? ""
//            item?.email = emailUser.text ?? ""
//            item?.sex = sexUser.text ?? ""
//        }
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "currentInfo" {
//        let currentInfo = segue.destination as? EditControl
//            currentInfo?.data = item
////            currentInfo?.data?.image = avataUser.image ?? UIImage()
////            currentInfo?.data?.name = nameUser.text ?? ""
////            currentInfo?.data?.date = birthDayUser.text ?? ""
////            currentInfo?.data?.email = emailUser.text ?? ""
////            currentInfo?.data?.sex = sexUser.text ?? ""
////            self.navigationController?.popViewController(animated: true)
//        }
//    }
  

    
    

   
}
