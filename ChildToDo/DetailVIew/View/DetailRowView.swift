//
//  DetailRowView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/09.
//

import SwiftUI

struct DetailRowView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State private var isEddit = false
    let todo: ToDo
    let todoDetail: ToDoDetail
    
    var body: some View {
        NavigationStack{
            HStack{
                Button {
                    isEddit = true
                } label: {
                    Image(systemName: "info.circle.fill")
                        .foregroundColor(.blue)
                }
                .buttonStyle(BorderlessButtonStyle())
                Text(todoDetail.name)
            }
            .sheet(isPresented: $isEddit){
                ToDoEditView(
                    todoName: todoDetail.name,
                    edit: { todoDetailname in
                        try homeViewModel.todoDetailSave(newTodoDetail: todoDetail, todo: todo, newName: todoDetailname)
                        isEddit = false
                    }
                )
            }
        }
    }
}


struct DetailRowView_Previews: PreviewProvider {
    static var previews: some View {
        DetailRowView(todo: ToDo(name: "帰りの会", toDoDetails: [ToDoDetail(name: "荷物かくにん", isChecked: false)]), todoDetail: ToDoDetail.init(name: "greeting", isChecked: false)
        )
    }
}
