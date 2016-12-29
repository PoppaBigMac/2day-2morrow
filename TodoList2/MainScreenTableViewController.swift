//
//  MainScreenTableViewController.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/11/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

/*********************************************************************
 * This file runs the main screen of the app that includes all of the
 * lists and the functionality to edit and add a list.
 ********************************************************************/

import UIKit
import os.log

class MainScreenTableViewController: UITableViewController, UINavigationControllerDelegate {
    // MARK: Properties
    var lists: [TodoList] = [TodoList]()
    var url = TodoItem.DocumentsDirectory.appendingPathComponent("lists")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If there are saved lists then we should load them. Else, let's start with the
        // user's previously saved lists
        if let savedLists = loadTodoLists() {
            os_log("Saved lists loaded", log: .default, type: .debug)
            lists = savedLists
        } else {
            os_log("Lists initialized", log: .default, type: .debug)
            let todayList = TodoList(title: "Today", items: [TodoItem]())
            let weekList = TodoList(title: "This Week", items: [TodoItem]())
            let monthList = TodoList(title: "This Month", items: [TodoItem]())
            let yearList = TodoList(title: "This Year", items: [TodoItem]())
            
            lists += [todayList, weekList, monthList, yearList]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        saveTodoLists()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "ListTitleCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ListTitleTableViewCell

        let list = lists[indexPath.row]
        cell.listTitle.text = list.title
        cell.itemsNumber.text = "\(list.getItemAmount())"

        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        // If the cell is one of the main four lists, it cannot be deleted
        if indexPath.row < 4 {
            return false
        }
        else {
            return true
        }
    }


    
    // Override to support editing the table view, such as deleting or inserting
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            lists.remove(at: indexPath.row)
            saveTodoLists()
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowList" {
            let todoListVC = segue.destination as! TodoListTableViewController
            
            if let selectedCell = sender as? ListTitleTableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell)!
                let selectedList = lists[indexPath.row]
                
                todoListVC.todoList = selectedList
            }
        }
    }

    // Allows us to get the information from NewListViewController so we can use it
    // to create a new cell when the save button is pressed
    @IBAction func unwindToMainScreen(sender: UIStoryboardSegue) {
        if let newListVC = sender.source as? NewListViewController {
            let newList = TodoList(title: newListVC.listName, items: [TodoItem]())
            let indexPath = IndexPath(row: lists.count, section: 0)
            lists += [newList]
            tableView.insertRows(at: [indexPath], with: .bottom)
        }
        saveTodoLists()
    }
    
    // MARK: NSCoding
    
    // Saves and loads lists from an NSKeyedArchiver and NSKeyedUnarchiver
    private func saveTodoLists() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(lists, toFile: url.path)
        
        if isSuccessfulSave {
            os_log("lists saved successfully", log: .default, type: .debug)
        } else {
            os_log("lists unable to save", log: .default, type: .error)
        }
    }
    
    private func loadTodoLists() -> [TodoList]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: url.path) as? [TodoList]
    }
    
    
    // MARK: Helper Methods

}
