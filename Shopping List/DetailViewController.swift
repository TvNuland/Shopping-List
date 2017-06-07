//
//  DetailViewController.swift
//  Shopping List
//
//  Created by Ton on 2017-05-30.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet var imageView: UIImageView!
    
    var theItem: ShoppingItems?
    var image: UIImage?
    
    // Do any additional setup after loading the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameText.text = theItem?.name
        self.priceText.text = theItem?.price
        if let image = ImageStore.sharedInstance.image(forKey: (theItem?.uniqueKey)!) {
            imageView.image = image
        }
    }
    
    // Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true) //closes the keyboard
        theItem?.name = nameText.text!
        theItem?.price = priceText.text!
        if image != nil {
            ImageStore.sharedInstance.setImage(image!, forKey: (theItem?.uniqueKey)!)
        }
    }
    
    
    // If the device has a camera, take a picture; otherwise,
    // just pick from photo library
    // Place image picker on the screen
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Get picked image from info dictionary
    // Put that image on the screen in the image view
    // Take image picker off the screen -
    // you must call this dismiss method
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
}
