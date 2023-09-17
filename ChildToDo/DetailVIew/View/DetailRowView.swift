//
//  DetailRowView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/09.
//

import SwiftUI

struct DetailRowView: View {
    
    @StateObject var detailViewModel: DetailViewModel
    let todoModel: ToDoModel
    let todo: ToDo
    let todoDetail: ToDoDetail
    
    init(todoModel: ToDoModel, todo: ToDo, todoDetail: ToDoDetail) {
        self._detailViewModel = StateObject(wrappedValue: DetailViewModel(todo: todo, todoDetail: todoDetail, toDoModel:todoModel))
        self.todoModel = todoModel
        self.todo = todo
        self.todoDetail = todoDetail
    }
    
    var body: some View {
        NavigationStack{
            HStack{
                Button {
                    detailViewModel.isShowEditView()
                } label: {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                }
                .buttonStyle(BorderlessButtonStyle())
                Text(todoDetail.name)
            }
            //MARK: - 選択された項目編集のシート
            .sheet(isPresented: $detailViewModel.isEditView){
                ToDoEditView(
                    todoName: todoDetail.name,
                    edit: { todoDetailname in
                        try detailViewModel.todoDetailSave(newTodoDetail: todoDetail, todo: todo, newName: todoDetailname)
                    }
                )
            }
        }
    }
}


//struct DetailRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailRowView(
//            detailViewModel: DetailViewModel(todo: ToDo(name: "", toDoDetails: []), todoDetail: ToDoDetail(name: "", isChecked: false), toDoModel: ToDoModel()),
//            todo: ToDo(name: "", toDoDetails: []), todoDetail: ToDoDetail(name: "", isChecked: false))
//    }
//}
