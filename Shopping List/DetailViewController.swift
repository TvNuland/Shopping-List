//
//  DetailViewController.swift
//  Shopping List
//
//  Created by Ton on 2017-05-30.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var priceText: UITextField!
    @IBOutlet weak var descriptionText: UILabel!
    
    var theItem: ShoppingItem?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nameText.text = theItem?.name
        self.priceText.text = theItem?.price
 }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true) //closes the keyboard
        theItem?.name = nameText.text!
        theItem?.price = priceText.text!
    }
    

}
