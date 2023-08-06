//
//  TodoItems.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/08/06.
//

import Foundation

class TodoViewModel:ObservableObject {
    private let userDefaultManager = UserDefaultManager()
    @Published var toDos = [
        ToDo(name: "朝の会",
             toDoDetails: [
                ToDoDetail(name: "うた", isChecked: false),
                ToDoDetail(name: "なまえよび", isChecked: false),
                ToDoDetail(name: "きょうのよてい", isChecked: false),
                ToDoDetail(name: "きょうのきゅうしょく", isChecked: false),
                ToDoDetail(name: "かけごえ", isChecked: false)
             ]),
                        
        ToDo(name: "帰りの会",
             toDoDetails: [
                ToDoDetail(name: "がんばったこと", isChecked: false),
                ToDoDetail(name: "わすれもののかくにん", isChecked: false),
                ToDoDetail(name: "かえりのかくにん", isChecked: false),
                ToDoDetail(name: "かけごえ", isChecked: false)
             ])
    ]
    {
        didSet {
           // print("🍔: HomeViewModelが持つ、toDos配列(todoDetailsが持つ、isCheckのtrueの数)")
            //変更前の値を調べる。
            oldValue.forEach{ todoItem in
                //toDoDetailsの中身から、trueのものを検出して、格納する。
                let count = todoItem.toDoDetails.filter({$0.isChecked}).count
               // print("\(todoItem.name)の変更前....", count)
            }
            //変更後の値を調べる。
            toDos.forEach{ todoItem  in
                let count = todoItem.toDoDetails.filter({$0.isChecked}).count
               // print("\(todoItem.name)の変更後....", count)
            }
            do {
                try userDefaultManager.save(toDo: toDos)
            } catch {
                let error = error as? DataConvertError ?? DataConvertError.unknown
                print(error.title)
            }
           // print("ーーーーーーーーーーーーーーーーーーーーーーーーーーーーー")
        }
    }
    
    
}
