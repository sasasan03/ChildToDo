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
       let bbb =  ToDoDetail(name: name, isCheck: false)
        print("llll",bbb)
        return bbb
    }
}

struct ToDo: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var toDoDetails: [ToDoDetail]
    
    func unchecked() -> ToDo {
         let aaa =  ToDo(name: name, toDoDetails: toDoDetails.map{ $0.unchecked() })
        print("FFF",aaa)
        return aaa
    }
}

extension Array where Element == ToDo {
    func unchecked() -> [ToDo]{
      let aa =  self.map{ todo in todo }
      print(">>>",aa)
        return aa
    }
}
