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
    @Published var isShowAddView = false
    init(todo: ToDo, todoDetail: ToDoDetail, isShowAddView: Bool = false) {
        self.todo = todo
        self.todoDetail = todoDetail
        self.isShowAddView = isShowAddView
    }
    
    func isShowDetailAddView(){
        isShowAddView = true
    }
    
    func isCloseDetailAddView(){
        isShowAddView = false
    }
    
    //.moveメソッドを使用して項目を入れ替えれる際に使用
//    func moveTodoDetail(indexSet: IndexSet, index: Int, todo: ToDo){
//        let todoIndex = todoIndex(todo: todo)
//        todo.toDoDetails.move(fromOffsets: indexSet, toOffset: index)
//
//    }
    
    //moveTodoDetailメソッドで内で、渡されてきたToDoのIntを検索するために使用
    func todoIndex(todo: ToDo) -> Int {
        guard let todoIndex = todo.toDoDetails.firstIndex(where: { $0.id == todo.id }) else { return 0 }
        //guard let index = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        return todoIndex
    }
    
    
}
