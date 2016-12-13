//
//  TodoItem.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/12/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

import UIKit

class TodoItem {
    // MARK: Properties
    var itemName: String
    var importance: Int
    
    init?(itemName: String, importance: Int) {
        self.itemName = itemName
        self.importance = importance
        
        // if there is no name, the initilizer must fail
        if itemName.isEmpty {
            return nil
        }
    }
}
