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
}

struct ToDo: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var toDoDetails: [ToDoDetail]
}
