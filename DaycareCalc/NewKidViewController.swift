//
//  NewKidViewController.swift
//  DaycareCalc
//
//  Created by Daniel Gonzalez on 8/6/22.
//

import Foundation
import UIKit

class NewKidViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var kidPicture: UIImageView!
    @IBOutlet weak var kidName: UITextField!
    
    var delegate: UIViewController?
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
    }
    
    @IBAction func pictureTouched(_ sender: Any) {
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.editedImage] as! UIImage
        kidPicture.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("User cancelled")
    }
    
    @IBAction func SaveButtonPressed(_ sender: Any) {
        let newKid = KidsDataController.controller.createKid(name: kidName.text ?? "?", picture: (kidPicture.image ?? UIImage(named: "photo"))!)
        let parentVC = delegate as! ViewController
        parentVC.updateCollectionWithNewKid(kid: newKid!)
    }
    
}
