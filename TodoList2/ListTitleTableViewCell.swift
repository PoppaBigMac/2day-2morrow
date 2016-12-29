//
//  ListTitleTableViewCell.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/11/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

/*********************************************************************
 * This file represents a cell within the MainScreenTableViewController
 ********************************************************************/

import UIKit

class ListTitleTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var listTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
