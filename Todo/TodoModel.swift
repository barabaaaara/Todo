//
//  TodoModel.swift
//  Todo
//
//  Created by 桑原佑輔 on 2021/02/13.
//

import Foundation
import RealmSwift

class TodoModel: Object{
    @objc dynamic var id: String = ""
    @objc dynamic var taskTitle: String = ""
    @objc dynamic var taskDetail: String? = nil
    @objc dynamic var taskDeadline: Data? = nil
    
}
