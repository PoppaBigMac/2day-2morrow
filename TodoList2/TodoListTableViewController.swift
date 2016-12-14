//
//  TodoListTableViewController.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/12/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

import UIKit
import os.log

class TodoListTableViewController: UITableViewController, UINavigationControllerDelegate {
    // MARK: Properties
    var todoList: TodoList = TodoList(todoItems: [TodoItem]())

    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedTodoList = loadTodoList() {
            todoList = savedTodoList
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.todoItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "TodoItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TodoItemTableViewCell
        
        let item = todoList.todoItems[indexPath.row]
        
        cell.todoItemImportance.rating = item.importance
        cell.todoItemName.text = item.itemName
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todoList.todoItems.remove(at: indexPath.row)
            saveTodoList()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            // Downcast destination to set some of its properties
            let viewControllerToEdit = segue.destination as! TodoItemViewController
            
            // get the selected cell sender
            if let selectedTodoItemCell = sender as? TodoItemTableViewCell {
                // Get index path for the selected cell and get the item it corresponds to
                let indexPath = tableView.indexPath(for: selectedTodoItemCell)!
                let selectedItem = todoList.todoItems[indexPath.row]
                
                // Set destination's item to the item that was selected
                viewControllerToEdit.todoItem = selectedItem
            }
        } else if segue.identifier == "NewItem" {
            print("New item is being created")
        }
    }
    
    @IBAction func unwindToTodoList(sender: UIStoryboardSegue) {
        // Downcast to get the item out of the sender view controller
        if let todoItemViewController = sender.source as? TodoItemViewController, let item = todoItemViewController.todoItem {
            // If there was a cell selected, update it. Else create a new one
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todoList.todoItems[selectedIndexPath.row] = item
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let indexPath = IndexPath(row: todoList.todoItems.count, section: 0)
                todoList.todoItems += [item]
                tableView.insertRows(at: [indexPath], with: .bottom)
            }
            
            // Save the items
            saveTodoList()
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let mainScreen = viewController as? MainScreenTableViewController {
            
        }
    }
    
    // MARK: Private Methods
    
    private func saveTodoList() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(todoList, toFile: TodoItem.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("itemsTodo saved successfully", log: OSLog.default, type: .debug)
        } else {
            os_log("Unable to save itemsTodo", log: OSLog.default, type: .error)
        }
    }
    
    private func loadTodoList() -> TodoList? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: TodoItem.ArchiveURL.path) as? TodoList
    }

}
