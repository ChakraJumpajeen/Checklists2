//
//  Checklist.swift
//  Checklists
//
//  Created by Chakra Jumpajeen on 9/8/21.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items = [ChecklistItem]()
    var iconName = "No Icon" //var iconName = "Appointments" // if you want all new checklists to have default icon as the “Appointments” icon
    //OR var items: [ChecklistItem] = [ChecklistItem]()
    //OR var items: [ChecklistItem] = []    //[] means: make an empty array of the specified type
    
    init(name: String, iconName: String = "No Icon") {
      self.name = name
      self.iconName = iconName
      super.init()
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
}
