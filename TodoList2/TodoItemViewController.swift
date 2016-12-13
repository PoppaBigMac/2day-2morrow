//
//  TodoItemViewController.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/12/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

import UIKit

class TodoItemViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var importanceRating: RatingController!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
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
