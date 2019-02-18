//
//  ViewController.swift
//  Todoey
//
//  Created by Brad Martin on 2/17/19.
//  Copyright © 2019 Brad Martin. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray : [TodoItem] = [TodoItem]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("TodoItems.plist")
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newTodoItem = TodoItem()
        newTodoItem.text = "First todo object from model."
        itemArray.append(newTodoItem)
        
        let newTodoItem2 = TodoItem()
        newTodoItem2.text = "Second todo object from model."
        itemArray.append(newTodoItem2)
        
        let newTodoItem3 = TodoItem()
        newTodoItem3.text = "Third todo object from model."
        itemArray.append(newTodoItem3)
        
//        if let items = defaults.array(forKey: "TodoObjectArray") as? [TodoItem] {
//            itemArray = items
//        }
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.text
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // need local variable to pass data in alert text field
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button in the alert
            
            let newTodoItem = TodoItem()
            newTodoItem.text = textField.text!
            self.itemArray.append(newTodoItem)
            
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        // save updated item array to persistent store
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array: \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
}

