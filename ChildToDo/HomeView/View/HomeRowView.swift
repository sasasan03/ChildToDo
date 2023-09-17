//
//  HomeRowView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct HomeRowView: View {
    
    @StateObject var homeViewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State var isEddit = false
    let todoModel : ToDoModel
    let todo: ToDo
    
    init(todoModel: ToDoModel, todo: ToDo) {
        self._homeViewModel = StateObject(wrappedValue: HomeViewModel(toDoModel: todoModel))
        self.todoModel = todoModel
        self.todo = todo
    }
    
    
    var body: some View {
        NavigationStack{
            HStack{
                Button {
                    homeViewModel.isShowEditView()
                } label: {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                }
                .buttonStyle(BorderlessButtonStyle())
                NavigationLink(todo.name,value: todo)
            }
            //MARK: - 選択された項目編集のシート
            .sheet(isPresented: $homeViewModel.isEditView){
                ToDoEditView(
                    todoName: todo.name,
                    edit: { todoName in
                       try homeViewModel.toDoSave(todoName: todoName, newToDo: todo)
                        dismiss()
                }
                )
                .presentationDetents([.medium, .large])
            }
        }
    }
}

struct HomeRowView_Previews: PreviewProvider {
    static var previews: some View {
       HomeRowView(
        todoModel: ToDoModel(),
        todo: ToDo(name: "さ", toDoDetails: [ToDoDetail(name: "し", isChecked: true)])
       )
    }
}
