//
//  HomeViewModel.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var isEdditHomeRowView = false
    @Published var isAddView = false
    @Published var isShowTodoDetailView = false
    
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
    
    //
    func todoDetailIndex(todo: ToDo, todoDetail: ToDoDetail) -> Int {
        guard  let toDoDetailIndex = todo.toDoDetails.firstIndex(where: { $0.id == todo.id }) else { return 0 }
        return toDoDetailIndex
    }
//🍔DetailViewModelへ
    //moveTodoDetailメソッドで内で、渡されてきたToDoのIntを検索するために使用
//    func todoIndex(todo: ToDo) -> Int {
//        guard let todoIndex = toDos.firstIndex(where: { $0.id == todo.id }) else { return 0 }
//        //guard let index = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
//        return todoIndex
//    }
//        //todoDetailの場所を変更させるために使用する
//    func moveTodoDetail(indexSet: IndexSet, index: Int, todo: ToDo){
//        let todoIndex = todoIndex(todo: todo)
//        self.toDos[todoIndex].toDoDetails.move(fromOffsets: indexSet, toOffset: index)
//    }
//🍔

    //⭐️toDosの場所を変更させるために使用する
    func moveTodo(indexSet: IndexSet, index: Int){
        self.toDos.move(fromOffsets: indexSet, toOffset: index)
    }
    //🍔ToDoDetailの要素を削除するために使用する🟥エラーを握りつぶしている
//    func deleteTodoDetail(todo: ToDo, todoDetail: ToDoDetail, offset: IndexSet)  {
//        guard let todoIndex = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
//        toDos[todoIndex].toDoDetails.remove(atOffsets: offset)
//    }
    //🍔
    
    //⭐️toDosの要素を削除するために使用する
    func deleteTodo(offset: IndexSet){
        self.toDos.remove(atOffsets: offset)
    }
    
    //アプリ起動時に保存されていた配列のデータを呼ぶ
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
    
    //⭐️toDos新しいTODOを追加するために使用
    func addTodo(text: String) throws {
        guard text != "" else {
            throw NonTextError.nonTodoText
        }
        self.toDos.append(ToDo(name: text, toDoDetails: []))
        isAddView = false
    }
    
    //AddViewを開かせる
    func isShowAddView(){
        isAddView = true
    }
    //TrainerAddViewを閉じさせる
    func isCloseAddView(){
        isAddView = false
    }

    //選択したToDoに新しいTodoDetailを追加するために使用
    //🍔
//    func addTodoDetail(text: String, todo: ToDo) throws {
//        if let index = toDos.firstIndex(of: todo){
//            var updatedToDo = todo
//            guard text != "" else {
//                throw NonTextError.nonTodoDetailText
//            }
//            updatedToDo.toDoDetails.append(ToDoDetail(name: text, isChecked: false))
//            toDos[index] = updatedToDo
//        }
//    }
    //🍔
    
    //MARK: detailViewへ渡させたTODO情報を配列の中から検索し、一致したTODOの情報を返すために使用
    func returnAdress(todo: ToDo?) -> ToDo? {
        guard let todo = todo else {
            return nil
        }
        //取得してきたTODOのIDを検索してTODODetailを返す。
        guard let index = toDos.firstIndex(where: { $0.id == todo.id }) else { return nil }
        return toDos[index]
    }
    
    func save(todoName: String, newToDo: ToDo) throws {
        guard let index = toDos.firstIndex(where: { $0.id == newToDo.id }) else { return }
        toDos[index] = newToDo
        guard todoName != "" else {
            throw NonTextError.nonTodoDetailText
        }
        toDos[index].name = todoName
    }
    //🍔
//    func todoDetailSave(newTodoDetail: ToDoDetail, todo: ToDo, newName: String) throws {
//        guard let index = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
//        guard  let dIndex = todo.toDoDetails.firstIndex(where: { $0.id == newTodoDetail.id }) else { return }
//        guard newName != "" else {
//            throw NonTextError.nonTodoDetailText
//        }
//        toDos[index].toDoDetails[dIndex].name = newName
//    }
    //🍔
}
