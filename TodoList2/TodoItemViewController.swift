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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingModally = presentingViewController is UINavigationController
        
        if isPresentingModally {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
