//
//  Category.swift
//  Todoey
//
//  Created by Brad Martin on 2/23/19.
//  Copyright © 2019 BradleypmartinSandbox. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let todoItems = List<TodoItem>()
}
