//
//  TableTableViewController.swift
//  Shopping List
//
//  Created by Ton on 2017-05-25.
//  Copyright © 2017 Ton van Nuland. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
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
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        TextFieldOutlet.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
        cell.detailTextLabel?.text = shoppingList[indexPath.row]
        cell.textLabel?.text = "row \(indexPath.row)"
        cell.imageView?.image = #imageLiteral(resourceName: "Ton 120")
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
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
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
    
}
