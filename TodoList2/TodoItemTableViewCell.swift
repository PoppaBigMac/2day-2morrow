//
//  TodoItemTableViewCell.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/12/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

/*********************************************************************
 * This file represents a cell in a TodoListTableViewController
 ********************************************************************/

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    @IBOutlet weak var todoItemName: UILabel!
    @IBOutlet weak var todoItemImportance: RatingController!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
