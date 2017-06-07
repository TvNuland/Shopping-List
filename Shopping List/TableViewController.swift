//
//  TableViewController.swift
//  Shopping List
//
//  Created by Ton on 2017-05-25.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    var shoppingItemArray: [ShoppingItems] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    var currentItem: ShoppingItems?
//    var imageStore: ImageStore!
    
    @IBAction func addItem(_ sender: Any) {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Add Item", message: "Enter Name and Price", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Add", style: .default) { (_) in
            
            //getting the input values from user
            let name = alertController.textFields?[0].text
            let price = alertController.textFields?[1].text
            let newShoppingItem = ShoppingItems(name: name!, price: price!, description: "empty")
            //           self.shoppingItemArray.append(newShoppingItem)
            DataProvider.sharedInstance.addOrEditShopItem(shopItem: newShoppingItem)
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Name"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Price"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func EditItem(_ sender: Any) {
        if isEditing {
            setEditing(false, animated: true)
        } else {
            setEditing(true, animated: true)
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ShoppingListTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ShoppingListTableViewCell")
        
        DataProvider.sharedInstance.getShoppingListData()
        DataProvider.sharedInstance.setupObservers()
        
        // Register to receive notification data
        NotificationCenter.default.addObserver(self, selector: #selector(TableViewController.notifyObservers), name:  NSNotification.Name(rawValue: "gotShoppingListData" ), object: nil)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func notifyObservers(notification: NSNotification) {
        var shopItemDict = notification.userInfo as! Dictionary<String, [ShoppingItems]>
        shoppingItemArray = shopItemDict["shoppingItems"]!
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShoppingListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as! ShoppingListTableViewCell
        let currentShoppingItem = shoppingItemArray[indexPath.row]
        cell.setDataForTableCell(shoppingListItem: currentShoppingItem)
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        print("editingStyle", editingStyle)
        if editingStyle == .delete {
            // tableView.deleteRows(at: [indexPath], with: .fade)
            ImageStore.sharedInstance.deleteImage(forKey: shoppingItemArray[indexPath.row].uniqueKey)
            DataProvider.sharedInstance.removeShopItem(shopItem: shoppingItemArray[indexPath.row])
//            shoppingItemArray.remove(at: indexPath.row)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = shoppingItemArray[fromIndexPath.row]
        shoppingItemArray.remove(at: fromIndexPath.row)
        shoppingItemArray.insert(itemToMove, at: to.row)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer is UITapGestureRecognizer {
            let location = touch.location(in: tableView)
            return (tableView.indexPathForRow(at: location) == nil)
        }
        return true
    }
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailView" {
            let detailView = segue.destination as! DetailViewController
            detailView.theItem = currentItem
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("resign")
        textField.resignFirstResponder()
        return true
    }
    /*
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     return tableView.rowHeight
     }
     */
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentItem = shoppingItemArray[indexPath.row]
        self.performSegue(withIdentifier: "detailView", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
}

