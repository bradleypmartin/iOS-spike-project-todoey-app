//
//  TodoItem.swift
//  Todoey
//
//  Created by Brad Martin on 2/17/19.
//  Copyright © 2019 BradleypmartinSandbox. All rights reserved.
//

import Foundation

class TodoItem: Encodable, Decodable {
    
    // Todo properties
    var text : String = ""
    var done : Bool = false
    
}
