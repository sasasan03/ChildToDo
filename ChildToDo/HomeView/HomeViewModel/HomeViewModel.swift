//
//  HomeViewModel.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var isAddView = false
    @Published var isEditView = false
    @Published var isShowTodoDetailView = false
    @Published var toDos: [ToDo]
    
    private let toDoModel: ToDoModel
    
    init(toDoModel: ToDoModel) {
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
    
    //MARK: 最上位のリスト内でどの項目を選択しているのか確認する
    func todoDetailIndex(todo: ToDo, todoDetail: ToDoDetail) -> Int {
        guard  let toDoDetailIndex = todo.toDoDetails.firstIndex(where: { $0.id == todo.id }) else { return 0 }
        return toDoDetailIndex
    }

    //MARK: ToDo項目の配置場所を変更する
    func moveTodo(indexSet: IndexSet, index: Int){
        toDoModel.moveTodo(indexSet: indexSet, index: index)
    }
    
    //MARK: ToDo項目を削除する
    func deleteTodo(offset: IndexSet){
        toDoModel.deleteTodo(offset: offset)
    }

    //MARK: ToDoへ新しい項目を追加
    func addTodo(text: String) throws {
        try toDoModel.addTodo(text: text)
        isAddView = false
    }
    
    //MARK: 選択されたtoDoを返す
    func returnAdress(todo: ToDo?) -> ToDo? {
        toDoModel.returnAdress(todo: todo)
    }
    
    //MARK: 選択した項目を修正した後に配列を上書きする
    func toDoSave(todoName: String, newToDo: ToDo) throws {
        try toDoModel.toDoSave(todoName: todoName, newToDo: newToDo)
    }
    
}
