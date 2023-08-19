//
//  DetailViewModel.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var sharedHomeViewModel: HomeViewModel
    @Published var todo: ToDo
    @Published var todoDetail: ToDoDetail
    @Published var isShowAddView = false
    
    //MARK: HomeViewModelから最新のtoDos情報を取得
    var toDos: [ToDo]{
        sharedHomeViewModel.toDos
    }
    
    init(sharedHomeViewModel: HomeViewModel, todo: ToDo, todoDetail: ToDoDetail, isShowAddView: Bool = false) {
        self.sharedHomeViewModel = sharedHomeViewModel
        self.todo = todo
        self.todoDetail = todoDetail
        self.isShowAddView = isShowAddView
    }
    
    //MARK: todoDetailの項目を削除
    func deleteTodoDetail(todo: ToDo, todoDetail: ToDoDetail, offset: IndexSet)  {
        guard let todoIndex = sharedHomeViewModel.toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        sharedHomeViewModel.toDos[todoIndex].toDoDetails.remove(atOffsets: offset)
    }
    
    //MARK: todoDetailの項目を移動
    func moveTodoDetail(indexSet: IndexSet, index: Int, todo: ToDo){
        guard let todoIndex = sharedHomeViewModel.toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        sharedHomeViewModel.toDos[todoIndex].toDoDetails.move(fromOffsets: indexSet, toOffset: index)
    }

    //MARK: toDosに有力された値を追加する
    func addTodoDetail(text: String, todo: ToDo) throws {
        if let index = toDos.firstIndex(of: todo){
            var updatedToDo = todo
            guard text != "" else {
                throw NonTextError.nonTodoDetailText
            }
            updatedToDo.toDoDetails.append(ToDoDetail(name: text, isChecked: false))
            sharedHomeViewModel.toDos[index] = updatedToDo
        }
    }
    
    //MARK: toDosのセルを選択し、新しく入力された値を上書きする
    func todoDetailSave(newTodoDetail: ToDoDetail, todo: ToDo, newName: String) throws {
        guard let index = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        guard  let dIndex = todo.toDoDetails.firstIndex(where: { $0.id == newTodoDetail.id }) else { return }
        guard newName != "" else {
            throw NonTextError.nonTodoDetailText
        }
        sharedHomeViewModel.toDos[index].toDoDetails[dIndex].name = newName
    }
}
