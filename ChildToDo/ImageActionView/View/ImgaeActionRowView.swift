//
//  ImgaeActionRowView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/11.
//
import Foundation
import SwiftUI

struct ImgaeActionRowView: View {
    
    @StateObject var imgaeActionViewModel: ImageActionViewModel
    let todo: ToDo
    let todoDetail: ToDoDetail
    let todoModel: ToDoModel
    
    init(todo: ToDo, todoDetail: ToDoDetail, todoModel: ToDoModel) {
        self._imgaeActionViewModel = StateObject(wrappedValue: ImageActionViewModel(todo: todo, todoDetail: todoDetail, toDoModel: todoModel))
        self.todo = todo
        self.todoDetail = todoDetail
        self.todoModel = todoModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack{
                //MARK: -『👍』のLottieのGIF
                if todoDetail.isChecked{
                    LottieView(resourceType: .good)
                        .frame(
                            width: geometry.size.width * 0.2,
                            height: geometry.size.height
                        )
                } else {
                    Color.clear
                        .frame(
                            width: geometry.size.width * 0.2,
                            height: geometry.size.height
                        )
                }
                //MARK: -『よくできました』と『入力された項目の文字』
                Text(todoDetail.isChecked ?"よくできました" : todoDetail.name)
                    .font(.system(
                        size: geometry.size.width * 0.07,
                        weight: .medium,
                        design: .rounded
                    ))
                    .foregroundColor(.black)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

//struct ImgaeActionRowView_Previews: PreviewProvider {
//    static var previews: some View {
//       ImageActionView(
//        imageActionViewModel: ImageActionViewModel(todo: ToDo(name: "", toDoDetails: []), todoDetail: ToDoDetail(name: "", isChecked: false), toDoModel: ToDoModel()),
//        todo: ToDo(name: "", toDoDetails: []),
//        todoDetail: ToDoDetail(name: "", isChecked: false), todoModel: ToDoModel()
//       )
//    }
//}
