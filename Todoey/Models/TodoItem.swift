//
//  TodoItem.swift
//  Todoey
//
//  Created by Brad Martin on 2/23/19.
//  Copyright © 2019 BradleypmartinSandbox. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var text: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "todoItems")
}
