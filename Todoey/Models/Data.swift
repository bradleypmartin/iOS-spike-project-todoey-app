//
//  Data.swift
//  Todoey
//
//  Created by Brad Martin on 2/22/19.
//  Copyright © 2019 BradleypmartinSandbox. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age: Int = 0
}
