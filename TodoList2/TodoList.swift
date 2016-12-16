//
//  TodoList.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/14/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

import UIKit
import os.log

class TodoList: NSObject, NSCoding {
    // MARK: Properties
    var title: String
    var items: [TodoItem]
    
    
    // MARK: Types
    struct PropertyKey {
        static let title = "title"
        static let items = "items"
    }
    
    init(title: String, items: [TodoItem]) {
        self.title = title
        self.items = items
    }
    
    // NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(items, forKey: PropertyKey.items)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String, let items = aDecoder.decodeObject(forKey: PropertyKey.items) as? [TodoItem] else {
            os_log("Unable to unarchive title and items", log: .default, type: .error)
            return nil
        }
        
        self.init(title: title, items: items)
    }
}
