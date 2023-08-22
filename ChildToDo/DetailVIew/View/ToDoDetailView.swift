//
//  ToDoDetailView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct ToDoDetailView: View {
    
    let todo: ToDo
    let todoDetail: ToDoDetail
    
    @EnvironmentObject var detailViewModel: DetailViewModel
    
    @State var isEdit = false
    @Environment(\.dismiss) var dismiss
    
    var imageActionViewModel: ImageActionViewModel{
        return ImageActionViewModel(sharedDetailViewModel: detailViewModel, todo: todo, todoDetail: todoDetail)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                List{
                    ForEach(todo.toDoDetails){ todoDetail in
                        DetailRowView(todo: todo,
                                      todoDetail: todoDetail)
                    }
                    .onMove { sourceIndices, destinationIndex in
                        print("🍔",sourceIndices,"🍟", destinationIndex)
                        detailViewModel.moveTodoDetail(indexSet: sourceIndices, index: destinationIndex, todo: todo)
                        print("🍹",sourceIndices,"🍟", destinationIndex)
                    }
                    .onDelete(perform: { indexSet in
                        detailViewModel.deleteTodoDetail(todo: todo, todoDetail: todoDetail, offset: indexSet)
                    }
                    )
                }
                .scrollContentBackground(.hidden)
                .background(Color.cyan)
                NavigationLink {
                    ImageActionView(todo: todo)
                        .environmentObject(imageActionViewModel)
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
                                .stroke(Color.green, lineWidth: 2)
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
        //MARK: - 新しい項目を追加するためのシート
        .sheet(isPresented: $isEdit){
            ToDoAddView(
                save: { text in
                   try detailViewModel.addTodoDetail(text: text, todo: todo)
                    dismiss()
                }
            )
        }
    }
}


struct ToDoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoDetailView(
            todo: ToDo(
                name: "朝の会",
                toDoDetails: [ToDoDetail(name: "あいさつ", isChecked: false)]
            ),
            todoDetail: ToDoDetail(name: "あさのうた", isChecked: false)
        )
        .environmentObject(
            DetailViewModel(
                sharedHomeViewModel: HomeViewModel(),
                todo:  ToDo(name: "朝の会",
                            toDoDetails: [ToDoDetail(name: "あいさつ", isChecked: false)]
                           ),
                todoDetail:  ToDoDetail(name: "あさのうた", isChecked: false))
        )
    }
}
