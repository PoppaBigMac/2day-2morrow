//
//  TodoItem.swift
//  TodoList2
//
//  Created by Cesar Martinez on 12/12/16.
//  Copyright © 2016 Cesar Martinez. All rights reserved.
//

/*********************************************************************
 * Data model of a TodoItem
 ********************************************************************/

import UIKit
// Very important to import this
import os.log

class TodoItem: NSObject, NSCoding {
    // MARK: Properties
    var itemName: String
    var importance: Int
    var completed: Bool = false
    
    // MARK: Archiving Paths
    // Use the file manager to find the urls that lead to the documents for this app, use the first
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    // Create a new url by appending the todoItems extension
    static let ArchiveURL = DocumentsDirectory.appendingPathExtension("todoItems")
    
    // MARK: Types
    struct PropertyKey {
        static let itemName = "itemName"
        static let importance = "importance"
        static let completed = "completed"
    }
    
    init?(itemName: String, importance: Int, completed: Bool) {
        self.itemName = itemName
        self.importance = importance
        self.completed = completed
        
        // if there is no name, the initilizer must fail
        if itemName.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(itemName, forKey: PropertyKey.itemName)
        aCoder.encode(importance, forKey: PropertyKey.importance)
        aCoder.encode(completed, forKey: PropertyKey.completed)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let itemName = aDecoder.decodeObject(forKey: PropertyKey.itemName) as? String else {
            os_log("Unable to decode itemName for TodoItem object", log: OSLog.default, type: .debug)
            return nil
        }
        let importance = aDecoder.decodeInteger(forKey: PropertyKey.importance)
        let completed = aDecoder.decodeBool(forKey: PropertyKey.completed)
        
        self.init(itemName: itemName, importance: importance, completed: completed)
    }
}
