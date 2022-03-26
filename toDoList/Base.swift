//
//  Base.swift
//  toDoList
//
//  Created by Andrey Krivokhizhin on 23.03.2022.
//

import Foundation

class Base {
    let defaults = UserDefaults.standard
    
    static let shared = Base()
    struct ToDoItem: Codable, Equatable {
        let title: String
        let category: String
        let comment: String
    }
    
    var toDoItems: [ToDoItem] {
        get {
            if let data = defaults.value(forKey: "toDoItemsArray") as? Data {
                return try! PropertyListDecoder().decode([ToDoItem].self, from: data)
            } else {
                return [ToDoItem]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                self.defaults.set(data, forKey: "toDoItemsArray")
            }
            
        }
    }
    
    func saveToDoItems(title: String, category: String, comment: String) {
        let item = ToDoItem(title: title, category: category, comment: comment)
        toDoItems.insert(item, at: 0)
    }
    func deleteToDoItems(itemIndex: Int) {
        toDoItems.remove(at: itemIndex)
    }

}
