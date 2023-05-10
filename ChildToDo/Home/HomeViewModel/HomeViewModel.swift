//
//  HomeViewModel.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var isAddView = false
    @Published var isShowTodoDetailView = false
    
    @Published var toDos = [
        ToDo(name: "朝の会",
             toDoDetails: [
                ToDoDetail(name: "うた"),
                ToDoDetail(name: "なまえよび"),
                ToDoDetail(name: "きょうのよてい"),
                ToDoDetail(name: "きょうのきゅうしょく"),
                ToDoDetail(name: "かけごえ")
             ]),
                        
        ToDo(name: "帰りの会",
             toDoDetails: [
                ToDoDetail(name: "がんばったこと"),
                ToDoDetail(name: "わすれもののかくにん"),
                ToDoDetail(name: "かえりのかくにん"),
                ToDoDetail(name: "かけごえ")
             ]),
        
    ]
    //UserDefaultでデータをデバイスに保存する処理を追加していく。
    private let userDefaultManager = UserDefaultManager()
    
    //HomeViewでSidebarから渡されてきたTodoが持っているTodoDetailのIndexを取得するために使用
    func todoDetailIndex(todo: ToDo, todoDetail: ToDoDetail) -> Int {
        guard  let toDoDetailIndex = todo.toDoDetails.firstIndex(where: {
             $0.id == todo.id
        }) else { return 0 }
        return toDoDetailIndex
    }

    //moveTodoDetailメソッドで内で、渡されてきたToDoのIntを検索するために使用
    func todoIndex(todo: ToDo) -> Int {
        guard let todoIndex = toDos.firstIndex(where: { $0.id == todo.id }) else { return 0 }
        return todoIndex
    }
    //todoDetailの場所を変更させるために使用する
    func moveTodoDetail(indexSet: IndexSet, index: Int, todo: ToDo){
        let todoIndex = todoIndex(todo: todo)
        self.toDos[todoIndex].toDoDetails.move(fromOffsets: indexSet, toOffset: index)
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }

    //toDosの場所を変更させるために使用する
    func moveTodo(indexSet: IndexSet, index: Int){
        self.toDos.move(fromOffsets: indexSet, toOffset: index)
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    //ToDoDetailの要素を削除するために使用する🟥エラーを握りつぶしている
    func deleteTodoDetail(todo: ToDo, todoDetail: ToDoDetail, offset: IndexSet)  {
        guard let todoIndex = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        toDos[todoIndex].toDoDetails.remove(atOffsets: offset)
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    //toDosの要素を削除するために使用する
    func deleteTodo(offset: IndexSet){
        self.toDos.remove(atOffsets: offset)
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    //アプリ起動時に保存されていた配列のデータを呼ぶ
    func onApper(){
        do {
            let savedTodos = try userDefaultManager.load()
            toDos = savedTodos
        } catch {
            let  error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    //toDos新しいTODOを追加するために使用
    func addTodo(text: String) throws {
        guard text != "" else {
            throw NonTextError.nonTodoText
        }
        self.toDos.append(ToDo(name: text, toDoDetails: []))
        do {
            try userDefaultManager.save(toDo: toDos )
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
        isAddView = false
    }
    
    //TrainerAddViewを開かせる
    func isShowAddView(){
        isAddView = true
    }
    //TrainerAddViewを閉じさせる
    func isCloseAddView(){
        isAddView = false
    }

    //選択したToDoに新しいTodoDetailを追加するために使用
    func addTodoDetail(text: String, todo: ToDo) throws {
        if let index = toDos.firstIndex(of: todo){
            var updatedToDo = todo
            guard text != "" else {
                throw NonTextError.nonTodoDetailText
            }
            updatedToDo.toDoDetails.append(ToDoDetail(name: text))
            toDos[index] = updatedToDo
        }
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    //detailViewへ渡させたTODO情報を配列の中から検索し、一致したTODOの情報を返すために使用
    func returnAdress(todo: ToDo?) -> ToDo? {
        guard let todo = todo else {
            return nil
        }
        //取得してきたTODOのIDを検索してTODODetailを返す。
        guard let index = toDos.firstIndex(where: { $0.id == todo.id }) else { return nil }
        return toDos[index]
    }
    
    func save(todoName: String, newToDo: ToDo){
        guard let index = toDos.firstIndex(where: { $0.id == newToDo.id }) else { return }
        toDos[index] = newToDo
        toDos[index].name = todoName
        print("%%%%$index", index)
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    func todoDetailSave(newTodoDetail: ToDoDetail, todo: ToDo, newName: String){
        guard let index = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        guard  let dIndex = todo.toDoDetails.firstIndex(where: { $0.id == newTodoDetail.id }) else { return }
        toDos[index].toDoDetails[dIndex].name = newName
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
}
