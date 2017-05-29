//
//  TableTableViewController.swift
//  Shopping List
//
//  Created by Ton on 2017-05-25.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    //var shoppingList = ["Apples", "Oranges", "Kiwis", "Bananas", "Bread", "Butter", "Cheese"]
    var shoppingList: [String] = []
    var savedShopplingList = UserDefaults.standard
    
    @IBOutlet weak var TextFieldOutlet: UITextField!
    
    @IBAction func addItem(_ sender: Any) {
        if TextFieldOutlet.text != "" {
            shoppingList.append(TextFieldOutlet.text!)
            TextFieldOutlet.text = ""
            self.tableView.reloadData()
            savedShopplingList.set(shoppingList, forKey: "shoppingList")
        }
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
        
        //self.tableView.setEditing(true, animated: true)
        
        shoppingList = savedShopplingList.object(forKey: "shoppingList") as? [String] ?? [String]()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShoppingListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListTableViewCell", for: indexPath) as! ShoppingListTableViewCell
        let currentShoppingItem = shoppingList[indexPath.row]
        let currentShoppingRow = indexPath.row
        cell.setDataForTableCell(shoppingListItem: currentShoppingItem, shoppingListRow: currentShoppingRow)
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
            shoppingList.remove(at: indexPath.row)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        self.tableView.reloadData()
        savedShopplingList.set(shoppingList, forKey: "shoppingList")
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = shoppingList[fromIndexPath.row]
        shoppingList.remove(at: fromIndexPath.row)
        shoppingList.insert(itemToMove, at: to.row)
        savedShopplingList.set(shoppingList, forKey: "shoppingList")
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
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
}

