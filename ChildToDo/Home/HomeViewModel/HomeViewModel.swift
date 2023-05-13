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
                ToDoDetail(name: "うた", isCheck: false),
                ToDoDetail(name: "なまえよび", isCheck: false),
                ToDoDetail(name: "きょうのよてい", isCheck: false),
                ToDoDetail(name: "きょうのきゅうしょく", isCheck: false),
                ToDoDetail(name: "かけごえ", isCheck: false)
             ]),
                        
        ToDo(name: "帰りの会",
             toDoDetails: [
                ToDoDetail(name: "がんばったこと", isCheck: false),
                ToDoDetail(name: "わすれもののかくにん", isCheck: false),
                ToDoDetail(name: "かえりのかくにん", isCheck: false),
                ToDoDetail(name: "かけごえ", isCheck: false)
             ]),
        
    ]
    //UserDefaultでデータをデバイスに保存する処理を追加していく。
    private let userDefaultManager = UserDefaultManager()
    
    func dTrueChange(todo: ToDo, todoDetail: ToDoDetail){
        guard let tIndex = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        print("<<<<index", tIndex)
        guard let dIndex = todo.toDoDetails.firstIndex(where: { $0.id == todoDetail.id }) else { return }
        print(">>>>", dIndex)
        toDos[tIndex].toDoDetails[dIndex].isCheck.toggle()
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print("1111",error.title)
        }
    }
    
    //HomeViewでSidebarから渡されてきたTodoが持っているTodoDetailのIndexを取得するために使用
    func todoDetailIndex(todo: ToDo, todoDetail: ToDoDetail) -> Int {
        guard  let toDoDetailIndex = todo.toDoDetails.firstIndex(where: { $0.id == todo.id }) else { return 0 }
        return toDoDetailIndex
    }

    //moveTodoDetailメソッドで内で、渡されてきたToDoのIntを検索するために使用
    func todoIndex(todo: ToDo) -> Int {
        guard let todoIndex = toDos.firstIndex(where: { $0.id == todo.id }) else { return 0 }
        //guard let index = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
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
            print("2222",error.title)
        }
    }

    //toDosの場所を変更させるために使用する
    func moveTodo(indexSet: IndexSet, index: Int){
        self.toDos.move(fromOffsets: indexSet, toOffset: index)
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print("3333",error.title)
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
            print("44444",error.title)
        }
    }
    
    //toDosの要素を削除するために使用する
    func deleteTodo(offset: IndexSet){
        self.toDos.remove(atOffsets: offset)
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print("55555",error.title)
        }
    }
    
    //アプリ起動時に保存されていた配列のデータを呼ぶ
    func onApper(){
        do {
            let savedTodos = try userDefaultManager.load()
            toDos = savedTodos
        } catch {
            let  error = error as? DataConvertError ?? DataConvertError.unknown
            print("66666",error.title)
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
            print("77777",error.title)
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
            updatedToDo.toDoDetails.append(ToDoDetail(name: text, isCheck: false))
            toDos[index] = updatedToDo
        }
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print("88888",error.title)
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
        do {
            try userDefaultManager.save(toDo: toDos)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print("99999",error.title)
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
            print("$$$$$$$",error.title)
        }
    }
}
