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
        GeometryReader { geometry in
            ZStack{
                List{
                    ForEach(todo.toDoDetails){ todoDetail in
                        DetailRowView(todo: todo,
                                      todoDetail: todoDetail)
                    }
                    .onMove { sourceIndices, destinationIndx in
                        homeViewModel.moveTodoDetail(indexSet: sourceIndices, index: destinationIndx, todo: todo)
                    }
                    .onDelete(perform: { indexSet in
                        homeViewModel.deleteTodoDetail(todo: todo, todoDetail: todoDetail, offset: indexSet)
                    }
                    )
                }
                .scrollContentBackground(.hidden)
                .background(Color.cyan)
                NavigationLink {
                    ImageActionView(todo: todo, todoDetail: todoDetail)
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

extension Color {
    static let ligthBlue = Color(red: 0.8, green: 1.0, blue: 1.0)
    static let ligthOrange = Color(red: 1.0, green: 0.6, blue: 0.4)
}
struct ToDoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoDetailView(todo: ToDo.init(name: "朝の会", toDoDetails: [ToDoDetail(name: "予定のかくにん", isCheck: false)]), todoDetail: ToDoDetail.init(name: "きゅうしょく", isCheck: false))
    }
}
