//
//  TodoItemViewController.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/12/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

import UIKit

class TodoItemViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var importanceRating: RatingController!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var todoItem: TodoItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todoItem = todoItem {
            navigationItem.title = todoItem.itemName
            itemNameTextField.text = todoItem.itemName
            importanceRating.rating = todoItem.importance
        }
        
        // Make self the delegate for the text field
        itemNameTextField.delegate = self
        
        checkNameValidity()
    }

    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkNameValidity()
        navigationItem.title = itemNameTextField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func checkNameValidity() {
        let text = itemNameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    // MARK: Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // If the current view controller was presented modally, then we want to dismiss it,
        // else we want to pop the view controller off the navigation stack.
        
        let isPresentingModally = presentingViewController is UINavigationController
        
        if isPresentingModally {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }


    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as! UIBarButtonItem {
            let name = itemNameTextField.text ?? "Default"
            let importance = importanceRating.rating
            
            todoItem = TodoItem(itemName: name, importance: importance, completed: false)!
        }
    }
    

}
