//
//  ToDoDetailView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct ToDoDetailView: View {
    //MARK: できたら使いたくない
    @EnvironmentObject var homeViewModel: HomeViewModel
    let todo: ToDo
    let todoDetail: ToDoDetail
    
    @EnvironmentObject var detailViewModel: DetailViewModel
    
    @State var isEdit = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                List{
                    ForEach(todo.toDoDetails){ todoDetail in
                        DetailRowView(todo: todo,
                                      todoDetail: todoDetail)
                    }
                    .onMove { sourceIndices, destinationIndex in
                        homeViewModel.moveTodoDetail(indexSet: sourceIndices, index: destinationIndex, todo: todo)
                    }
                    .onDelete(perform: { indexSet in
                        homeViewModel.deleteTodoDetail(todo: todo, todoDetail: todoDetail, offset: indexSet)
                    }
                    )
                }
                .scrollContentBackground(.hidden)
                .background(Color.cyan)
                NavigationLink {
                    ImageActionView(todo: todo)
                } label: {
                    Text("やってみよう")
                        .font(.system(
                            size: geometry.size.width * 0.07,
                            weight: .regular,
                            design: .rounded
                        ))
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                        .padding()
                        .foregroundColor(.white)
                }
                .offset(CGSize(width: 0.0, height: geometry.size.height * 0.45))
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isEdit = true
                    //homeViewModel.isEdditTrue()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isEdit){//$homeViewModel.isEddit) {
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
        ToDoDetailView(todo: ToDo.init(name: "朝の会", toDoDetails: [ToDoDetail(name: "予定のかくにん", isChecked: false)]), todoDetail: ToDoDetail.init(name: "きゅうしょく", isChecked: false))
    }
}
