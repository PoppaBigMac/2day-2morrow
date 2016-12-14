//
//  TodoList.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/14/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

import UIKit

class TodoList {
    // MARK: Properties
    var todoItems: [TodoItem]
    
    init(todoItems: [TodoItem]) {
        self.todoItems = todoItems
    }
}
