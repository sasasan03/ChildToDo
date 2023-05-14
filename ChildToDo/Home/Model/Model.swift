//
//  Model.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation

struct ToDoDetail: Identifiable, Hashable, Codable  {
    var id = UUID()
    var name: String
    var isCheck: Bool
    
    func unchecked() -> ToDoDetail {
        ToDoDetail(name: name, isCheck: false)
    }
}

struct ToDo: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var toDoDetails: [ToDoDetail]
    
    func unchecked() -> ToDo {
        ToDo(name: name, toDoDetails: toDoDetails.map{ $0.unchecked() })
    }
}

extension Array where Element == ToDo {
    func unchecked() -> [ToDo]{
        self.map{ todo in todo}
    }
}
