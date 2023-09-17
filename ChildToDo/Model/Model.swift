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
    var isChecked: Bool
    
    //TODO: ImageActionRowViewの右上のリセットボタンで使用したい。全てのその配列のBoolを全てfalseに切り替える。
    func unchecked() -> ToDoDetail {
        let todoDetail =  ToDoDetail(id: id, name: name, isChecked: false)
        return todoDetail
    }
}

struct ToDo: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var toDoDetails: [ToDoDetail]
    
    //TODO: ImageActionRowViewの右上のリセットボタンで使用したい。全てのその配列のBoolを全てfalseに切り替える。
    func unchecked() -> ToDo {
         let toDo =  ToDo(id: id, name: name, toDoDetails: toDoDetails.map{ $0.unchecked() })
        return toDo
    }
}

