//
//  HomeRowView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct HomeRowView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    let todo: ToDo
    @State var isEddit = false
    
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
                NavigationLink(todo.name,value: todo)
            }
            //MARK: - 選択された項目編集のシート
            .sheet(isPresented: $isEddit){
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
            todo: ToDo(name: "朝の会",
                       toDoDetails: [ToDoDetail(name: "あいさつ", isChecked: false)]
                      )
        )
    }
}
