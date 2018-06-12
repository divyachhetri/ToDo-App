//
//  Category.swift
//  ToDo App
//
//  Created by Divya Pandit Chhetri on 6/11/18.
//  Copyright © 2018 Divya Pandit Chhetri. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object{
    
    @objc dynamic var name : String = ""
     let items = List<Item>()

}
