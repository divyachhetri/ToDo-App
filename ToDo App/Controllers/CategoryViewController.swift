//
//  CategoryViewControllerTableViewController.swift
//  ToDo App
//
//  Created by Divya Pandit Chhetri on 6/11/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let desinationVC = segue.destination as! ToDOListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            desinationVC.selectedCategory = categoryArray[indexPath.row]
            
        }
        
    }

    
    
    @IBAction func addButtomPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            self.saveCategory()
            
            
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (cancelAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter New Category"
            textField = alertTextField
        }
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    func saveCategory(){
        do {
        try context.save()
        }catch {
            print("Error: \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategory() {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
           
            categoryArray = try context.fetch(request)
        }catch {
            print("Error Readinf Data: \(error)")
            
        }
        tableView.reloadData()
    }
    
    
}
