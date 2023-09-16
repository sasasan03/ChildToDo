//
//  DetailViewModel.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation

class DetailViewModel: ObservableObject {
    
    @Published var todo: ToDo
    @Published var todoDetail: ToDoDetail
    @Published var isAddView = false
    @Published var isEditView = false
    @Published var toDos: [ToDo]
    
    private let toDoModel: ToDoModel
    
    init(todo: ToDo, todoDetail: ToDoDetail, isAddView: Bool = false, isEditView: Bool = false, toDoModel: ToDoModel) {
        self.todo = todo
        self.todoDetail = todoDetail
        self.isAddView = isAddView
        self.isEditView = isEditView
        self.toDoModel = toDoModel
        
        toDos = [ToDo(name: "", toDoDetails: [])]
        
        toDoModel.$toDos
            .assign(to: &$toDos)
    }
    
    //MARK: AddViewを開かせる
    func isShowAddView(){
        isAddView = true
    }
    
    //MARK: EditViewを開かせる
    func isShowEditView(){
        isEditView = true
    }
    
    //MARK: todoDetailの項目を削除
    func deleteTodoDetail(todo: ToDo, todoDetail: ToDoDetail, offset: IndexSet)  {
        toDoModel.deleteTodoDetail(todo: todo, todoDetail: todoDetail, offset: offset)
    }
    
    //MARK: todoDetailの項目を移動
    func moveTodoDetail(indexSet: IndexSet, index: Int, todo: ToDo){
        toDoModel.moveTodoDetail(indexSet: indexSet, index: index, todo: todo)
    }

    //MARK: toDosに入力された値を追加する
    func addTodoDetail(text: String, todo: ToDo) throws {
        try toDoModel.addTodoDetail(text: text, todo: todo)
    }
    
    //MARK: toDosのセルを選択し、新しく入力された値を上書きする
    func todoDetailSave(newTodoDetail: ToDoDetail, todo: ToDo, newName: String) throws {
        try toDoModel.todoDetailSave(newTodoDetail: newTodoDetail, todo: todo, newName: newName)
    }
}
