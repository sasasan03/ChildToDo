//
//  ImageActionView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct ImageActionView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    let todo: ToDo
    let todoDetail: ToDoDetail
    
    var body: some View {
        GeometryReader { geometry in
            List(todo.toDoDetails) { dTodo in
                DetailRowView(todo: todo,
                              todoDetail: todoDetail)
//                    .background(item.isChecked
//                                ? Color.cyan
//                                : Color.orange)
                    .frame(height: geometry.size.height * 0.1)
                    .offset(x: 1 ,y: geometry.size.height * 0.009)
            }
        }
    }
}

struct ImageActionView_Previews: PreviewProvider {
    static var previews: some View {
        ImageActionView(todo: ToDo.init(name: "朝の会", toDoDetails: [ToDoDetail(name: "挨拶")]), todoDetail: ToDoDetail.init(name: "予定"))
    }
}
