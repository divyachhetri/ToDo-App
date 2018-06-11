//
//  ViewController.swift
//  ToDo App
//
//  Created by Divya Pandit Chhetri on 6/10/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import UIKit

class ToDOListViewController: UITableViewController {

    var itemArray = [Item]()
     let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(dataFilePath!)
        loadItems()
 
        
    }
    
    //MARK - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellItem", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.itemName
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    //MARK - TableView Delegates
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
           let title = Item()
            title.itemName = textField.text!
           self.itemArray.append(title)
           self.saveItems()
            
           
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancel) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter New Item"
            textField = alertTextField
        }
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    func saveItems(){
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch {
            print("Error: \(error)")
            
        }
        tableView.reloadData()
        
        
    }
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            
            } catch{
                print("Error: \(error)")
                
            }
            
     
    }
    
    }
}





