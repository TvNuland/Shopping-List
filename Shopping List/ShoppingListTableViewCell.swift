//
//  ShoppingListTableViewCell.swift
//  Shopping List
//
//  Created by Ton on 2017-05-29.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shoppingListImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setDataForTableCell(shoppingListItem: ShoppingItems) {
        if let image = ImageStore.sharedInstance.image(forKey: shoppingListItem.uniqueKey) {
            self.shoppingListImageView.image = image
        }
        else {
            self.shoppingListImageView.image = #imageLiteral(resourceName: "shopping-icon")
            
        }
        self.titleLabel?.text = shoppingListItem.name
        self.detailTextView?.text = shoppingListItem.price
        DataProvider.sharedInstance.addOrEditShopItem(shopItem: shoppingListItem)
    }
    
}
