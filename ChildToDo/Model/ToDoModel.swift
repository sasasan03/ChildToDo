//
//  ToDoModel.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/09/16.
//

import Foundation

class ToDoModel: ObservableObject {
    
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
        //プロパティの更新が終わった後に保存がかかる。
        didSet {
            do {
                try userDefaultManager.save(toDo: toDos)
            } catch {
                let error = error as? DataConvertError ?? DataConvertError.unknown
                print(error.title)
            }
        }
    }
    
    
    //MARK: ToDo項目の配置場所を変更する
    func moveTodo(indexSet: IndexSet, index: Int){
        self.toDos.move(fromOffsets: indexSet, toOffset: index)
    }
    
    //MARK: ToDo項目を削除する
    func deleteTodo(offset: IndexSet){
        self.toDos.remove(atOffsets: offset)
    }

    //MARK: ToDoへ新しい項目を追加
    func addTodo(text: String) throws {
        guard text != "" else {
            throw NonTextError.nonTodoText
        }
        self.toDos.append(ToDo(name: text, toDoDetails: []))
    }
    
    //MARK: 選択されたtoDoを返す
    func returnAdress(todo: ToDo?) -> ToDo? {
        guard let todo = todo else { return nil }
        //取得してきたTODOのIDを検索してTODODetailを返す。
        guard let index = toDos.firstIndex(where: { $0.id == todo.id }) else { return nil }
        return toDos[index]
    }
    
    //MARK: 選択した項目を修正した後に配列を上書きする
    func toDoSave(todoName: String, newToDo: ToDo) throws {
        guard let index = toDos.firstIndex(where: { $0.id == newToDo.id }) else { return }
        toDos[index] = newToDo
        guard todoName != "" else {
            throw NonTextError.nonTodoDetailText
        }
        toDos[index].name = todoName
    }
    
    //MARK: アプリ起動時に保存されていた配列のデータを呼ぶ
    func onApper(){
        do {
            let savedTodos = try userDefaultManager.load()
            toDos = savedTodos
        } catch {
            let  error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    
    
}
