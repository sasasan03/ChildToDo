//
//  HomeViewModel.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    private let userDefaultManager = UserDefaultManager()
    @Published var isAddView = false
    @Published var isEditView = false
    @Published var isShowTodoDetailView = false
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
                print("カウント🍹",toDos[0].name)
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
    
    //MARK: AddViewを開かせる
    func isShowAddView(){
        isAddView = true
    }
    
    //MARK: EditViewを開かせる
    func isShowEditView(){
        isEditView = true
    }
    
    //MARK: 最上位のリスト内でどの項目を選択しているのか確認する
    func todoDetailIndex(todo: ToDo, todoDetail: ToDoDetail) -> Int {
        guard  let toDoDetailIndex = todo.toDoDetails.firstIndex(where: { $0.id == todo.id }) else { return 0 }
        return toDoDetailIndex
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
        isAddView = false
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
            savedTodos.forEach{ todoItem in
                let count = todoItem.toDoDetails.filter({$0.isChecked}).count
              //  print("🥪: HomeViewModelのonApperメソッドで書き換えられたtoDos配列(todoDetailsが持つ、isCheckのtrueの数、)", count)
              //  print("〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜")
            }
            toDos = savedTodos
        } catch {
            let  error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
}
