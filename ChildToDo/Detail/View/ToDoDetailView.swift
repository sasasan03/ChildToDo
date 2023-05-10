//
//  ToDoDetailView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct ToDoDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var detailViewModel: DetailViewModel
    @State var isEdit = false
    let todo: ToDo
    let todoDetail: ToDoDetail
    
    var body: some View {
        List{
            ForEach(todo.toDoDetails){ todoDetail in
                DetailRowView(todo: todo,
                              todoDetail: todoDetail) { todoDetail in
                    homeViewModel.todoDetailUpdate(newTodoDetail: todoDetail, todo: todo)
                }
            }
            .onMove { sourceIndices, destinationIndx in
                homeViewModel.moveTodoDetail(indexSet: sourceIndices, index: destinationIndx, todo: todo)
            }
            .onDelete(perform: { indexSet in
                homeViewModel.deleteTodoDetail(todo: todo, todoDetail: todoDetail, offset: indexSet)
            })
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isEdit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isEdit) {
            ToDoAddView(
                save: { text in
                   try homeViewModel.addTodoDetail(text: text, todo: todo)
                    dismiss()
                }
            )
        }
    }
}

struct ToDoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoDetailView(todo: ToDo.init(name: "朝の会", toDoDetails: [ToDoDetail(name: "予定のかくにん")]), todoDetail: ToDoDetail.init(name: "きゅうしょく"))
    }
}
