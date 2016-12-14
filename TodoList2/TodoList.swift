//
//  TodoList.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/14/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

import UIKit

class TodoList: NSObject {
    // MARK: Properties
    var title: String
    var items: [TodoItem]
    
    init(title: String, items: [TodoItem]) {
        self.title = title
        self.items = items
    }
}
