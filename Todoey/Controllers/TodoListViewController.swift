//
//  ViewController.swift
//  Todoey
//
//  Created by Brad Martin on 2/17/19.
//  Copyright © 2019 Brad Martin. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var todoItems : Results<TodoItem>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.text
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // order of operations is *very* important here (deletion functionality)
//        context.delete(todoItems[indexPath.row])
//        todoItems.remove(at: indexPath.row)
        
        //todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        // need local variable to pass data in alert text field
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button in the alert
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newTodoItem = TodoItem()
                        newTodoItem.text = textField.text!
                        currentCategory.todoItems.append(newTodoItem)
                    }
                } catch {
                    print("Error saving new items: \(error)")
                }
            }
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems() {

        todoItems = selectedCategory?.todoItems.sorted(byKeyPath: "text", ascending: true)

        tableView.reloadData()
    }
    
}

// MARK: - Search Bar Delegate methods

//extension TodoListViewController: UISearchBarDelegate {
//
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        // query DB when user interacts with search bar
//        let request : NSFetchRequest<TodoItem> = TodoItem.fetchRequest()
//
//        let predicate = NSPredicate(format: "text CONTAINS[cd] %@", searchBar.text!)
//        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0 {
//            loadItems()
//
//            // dismiss search bar even if background tasks are happening
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//        }
//    }
//
//}

