//
//  EditControl.swift
//  MoviesApp v.3
//
//  Created by VuTQ10 on 12/19/19.
//  Copyright © 2019 VuTQ10. All rights reserved.
//

import UIKit

class EditControl: UIViewController {

    @IBOutlet weak var avataEdit: UIImageView!
    @IBOutlet weak var nameEdit: UITextField!
    @IBOutlet weak var birthDayEdit: UITextField!
    @IBOutlet weak var emailEdit: UITextField!
    @IBOutlet weak var sexDisplay: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
   
    var data: TypeInfor?
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentedControl.tintColor = UIColor.white
//        if data != nil {
//        avataEdit.image = data?.image
//        nameEdit.text = data?.name
//        birthDayEdit.text = data?.date
//        emailEdit.text = data?.email
//        sexDisplay.text = data?.sex
//        }
     fetchObject()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
    }
    func fetchObject() {
        if let data = try? AppDelegate.context.fetch(Information.fetchRequest()) as [Information] {
            data.forEach { value in
                avataEdit.image = value.imageUser as? UIImage
                nameEdit.text = value.nameUser
                birthDayEdit.text = value.birthDay
                emailEdit.text = value.email
                sexDisplay.text = value.sex
            }
        }
    }
    

    @IBAction func chooseAvata(_ sender: UITapGestureRecognizer) {
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image
             imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func chooseSex(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            sexDisplay.text = "Male"
        default:
            sexDisplay.text = "Female"
        }
    }
    
    @IBAction func saveEdit(_ sender: UIButton) {
        let entity = Information(context: AppDelegate.context)
        if let content = avataEdit.image {
            entity.imageUser = content
        }
        if let nameText = nameEdit.text {
            entity.nameUser = nameText
        }
        if let dateText = birthDayEdit.text {
            entity.birthDay = dateText
        }
        if let emailText = emailEdit.text {
            entity.email = emailText
        }
        if let sexText = sexDisplay.text {
            entity.sex = sexText
        }
        AppDelegate.saveContext()
        
        dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name("Keep"), object: nil)
        }
    }
    
    @IBAction func cancelEdit(_ sender: UIButton) {
        dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name("Keep"), object: nil)
        }
    }
    
}
extension EditControl: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        avataEdit.image = selectedImage
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
}
