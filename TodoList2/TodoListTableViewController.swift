//
//  TodoListTableViewController.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/12/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

/*********************************************************************
 * This file controls each TodoList and shows it in a table view format
 ********************************************************************/

import UIKit
import os.log

class TodoListTableViewController: UITableViewController, UINavigationControllerDelegate {
    // MARK: Properties
    var todoList: TodoList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = todoList?.title
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList!.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "TodoItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TodoItemTableViewCell
        
        let item = todoList!.items[indexPath.row]
        
        cell.todoItemImportance.rating = item.importance
        cell.todoItemName.text = item.itemName
        if item.completed {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let completeAction = UITableViewRowAction(style: .normal, title: "Complete") {(action: UITableViewRowAction, indexPath: IndexPath) -> Void in

            let cell = tableView.cellForRow(at: indexPath) as! TodoItemTableViewCell
            let item = self.todoList!.items[indexPath.row]
            item.completed = !item.completed
            
            if item.completed {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            tableView.isEditing = false
        }
        
        completeAction.backgroundColor = .blue
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") {(action: UITableViewRowAction, indexPath: IndexPath) -> Void in
            
            // Delete the row from the data source
            self.todoList?.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return [deleteAction, completeAction]
        
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
                let selectedItem = todoList?.items[indexPath.row]
                
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
                todoList?.items[selectedIndexPath.row] = item
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                let indexPath = IndexPath(row: (todoList?.items.count)!, section: 0)
                todoList?.items += [item]
                tableView.insertRows(at: [indexPath], with: .bottom)
            }

        }
    }

}
