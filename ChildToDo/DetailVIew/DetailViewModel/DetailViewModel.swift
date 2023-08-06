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
  //🤢  @Published var isEdditHomeRowView = false
    init(todo: ToDo, todoDetail: ToDoDetail, isShowAddView: Bool = false) {
        self.todo = todo
        self.todoDetail = todoDetail
        self.isShowAddView = isShowAddView
    }
    
    
    func deleteTodoDetail(todo: ToDo, todoDetail: ToDoDetail, offset: IndexSet)  {
        guard let todoIndex = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        toDos[todoIndex].toDoDetails.remove(atOffsets: offset)
    }
    
    func detailBoolFalse(){
        toDos = toDos.map{ toDo -> ToDo in
            var details: [ToDoDetail] = []
            toDo.toDoDetails.forEach{ d in
                var detail = ToDoDetail(name: d.name, isChecked: false)
                detail.id = d.id
                details.append(detail)
            }
            var newToDo = ToDo(name: toDo.name, toDoDetails: details)
            newToDo.id = toDo.id
            return toDo
        }
    }
    //🤢
//    func isEdditTrue(){
//        isEdditHomeRowView = true
//    }
    
    func isShowDetailAddView(){
        isShowAddView = true
    }
    
    func isCloseDetailAddView(){
        isShowAddView = false
    }
    //.moveメソッドを使用して項目を入れ替えれる際に使用
//    func moveTodoDetail(indexSet: IndexSet, index: Int, todo: [ToDo]){
//        homeViewModel?.toDos.move(fromOffsets: indexSet, toOffset: index)
//    }
    //MARK: inout引数はだめ。理由　→
//    func moveTodoDetail(indexSet: IndexSet, index: Int, todo: inout [ToDo]){
//        todo.move(fromOffsets: indexSet, toOffset: index)
//    }
    
    
    //moveTodoDetailメソッドで内で、渡されてきたToDoのIntを検索するために使用
    func todoIndex(todo: ToDo) -> Int {
        guard let todoIndex = todo.toDoDetails.firstIndex(where: { $0.id == todo.id }) else { return 0 }
        //guard let index = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        return todoIndex
    }
    
    func addTodoDetail(text: String, todo: ToDo) throws {
        if let index = toDos.firstIndex(of: todo){
            var updatedToDo = todo
            guard text != "" else {
                throw NonTextError.nonTodoDetailText
            }
            updatedToDo.toDoDetails.append(ToDoDetail(name: text, isChecked: false))
            toDos[index] = updatedToDo
        }
    }
    
    func todoDetailSave(newTodoDetail: ToDoDetail, todo: ToDo, newName: String) throws {
        guard let index = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        guard  let dIndex = todo.toDoDetails.firstIndex(where: { $0.id == newTodoDetail.id }) else { return }
        guard newName != "" else {
            throw NonTextError.nonTodoDetailText
        }
        toDos[index].toDoDetails[dIndex].name = newName
    }
}
