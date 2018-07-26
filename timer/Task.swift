//
//  Task.swift
//  timer
//
//  Created by Tsang Ka Kui on 26/7/2018.
//  Copyright © 2018年 Tsang Ka Kui. All rights reserved.
//

import Realm
import RealmSwift

class Task: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var timeSpent = ""
    
}
