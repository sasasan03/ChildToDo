//
//  ToDoDetailView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct ToDoDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var detailViewModel: DetailViewModel
    @StateObject var imageActionViewModel: ImageActionViewModel
    let todo: ToDo
    let todoDetail: ToDoDetail
    let todoModel: ToDoModel
    
    init(todo: ToDo, todoDetail: ToDoDetail, todoModel: ToDoModel) {
        self._detailViewModel = StateObject(wrappedValue: DetailViewModel(todo: todo, todoDetail: todoDetail, toDoModel: todoModel))
        self._imageActionViewModel = StateObject(wrappedValue: ImageActionViewModel(todo: todo, todoDetail: todoDetail, toDoModel: todoModel))
        self.todo = todo
        self.todoDetail = todoDetail
        self.todoModel = todoModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                List{
                    ForEach(todo.toDoDetails){ todoDetail in
                        DetailRowView(todoModel: todoModel, todo: todo, todoDetail: todoDetail)
                    }
                    .onMove { sourceIndices, destinationIndex in
                        detailViewModel.moveTodoDetail(indexSet: sourceIndices, index: destinationIndex, todo: todo)
                    }
                    .onDelete(perform: { indexSet in
                        detailViewModel.deleteTodoDetail(todo: todo, todoDetail: todoDetail, offset: indexSet)
                    }
                    )
                }
                .scrollContentBackground(.hidden)
                .background(Color.cyan)
                NavigationLink {
                    ImageActionView(todo: todo, todoDetail: todoDetail, todoModel: todoModel)
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
                    detailViewModel.isShowAddView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        //MARK: - 新しい項目を追加するためのシート
        .sheet(isPresented: $detailViewModel.isAddView){
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
            todo: ToDo(name: "う", toDoDetails: [ToDoDetail(name: "え", isChecked: true)]),
            todoDetail: ToDoDetail(name: "お", isChecked: true),
            todoModel: ToDoModel()
        )
    }
}
