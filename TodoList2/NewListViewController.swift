//
//  NewListViewController.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/19/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

/*********************************************************************
 * This file is what controls the view which allows you to add a new 
 * list to the Main Screen
 ********************************************************************/

import UIKit

class NewListViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    @IBOutlet weak var listNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var listName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        listNameTextField.delegate = self
        
        checkValidity()
    }
    
    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidity()
        navigationItem.title = listNameTextField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func checkValidity() {
        let text = listNameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as? UIBarButtonItem {
            listName = listNameTextField.text ?? "default"
        }
    }
 
    
    // MARK: Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    
    

}
