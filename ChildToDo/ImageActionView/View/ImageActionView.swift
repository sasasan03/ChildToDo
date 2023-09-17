//  ImageActionView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct ImageActionView: View {
    
    @StateObject var imageActionViewModel: ImageActionViewModel
    let todo: ToDo
    let todoDetail: ToDoDetail
    let todoModel: ToDoModel
    
    init(todo: ToDo, todoDetail: ToDoDetail, todoModel: ToDoModel) {
        self._imageActionViewModel = StateObject(wrappedValue: ImageActionViewModel(todo: todo, todoDetail: todoDetail, toDoModel: todoModel))
        self.todo = todo
        self.todoDetail = todoDetail
        self.todoModel = todoModel
    }
    
    //TODO: 文字数に制限をいれて表示の限界を決める
    //現状１０文字以上の文字は潰れてしまう。
    var body: some View {
        GeometryReader { geometry in
            List(todo.toDoDetails) { todoD in
                ImageActionRowView(todo: todo, todoDetail: todoD, todoModel: todoModel)
                    .background(todoD.isChecked ? Color.lightOrange : Color.lightBlue)
                    .cornerRadius(15)
                    .frame(height: geometry.size.height * 0.1)
                    .rotationEffect(Angle(degrees
                                          : todoD.isChecked
                                          ? 360 : 0
                                         )
                    )
                    .animation(.default,value:todoD.isChecked)
                    .onTapGesture(count: 2) {
                        if !todoD.isChecked {
                            crappingHandsSound()
                        }
                        imageActionViewModel.isCheckedToChange(todo: todo, todoDetail: todoD)
                    }
            }
            //MARK: - 画面右上リセットボタン
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        imageActionViewModel.isCheckedToAllFalse(todo: todo)
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.green)
        }
    }
}


struct ImageActionView_Previews: PreviewProvider {
    static var previews: some View {
        ImageActionView(
            todo: ToDo(name: "ああ", toDoDetails: [ToDoDetail(name: "いい", isChecked: true)]),
            todoDetail: ToDoDetail(name: "まま", isChecked: false),
            todoModel: ToDoModel()
        )
    }
}
