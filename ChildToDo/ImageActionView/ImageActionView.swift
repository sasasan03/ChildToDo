//
//  ImageActionView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct ImageActionView: View {
    
   // @StateObject var homeViewModel = HomeViewModel()
    @EnvironmentObject var homeViewModel: HomeViewModel
    let todo: ToDo
    let todoDetail: ToDoDetail
    
    var body: some View {
        GeometryReader { geometry in
            List(todo.toDoDetails) { todoD in
                ImgaeActionRowView(todoDetail: todoD, todo: todo)
                    .background(todoD.isCheck
                                ? Color.cyan
                                : Color.orange)
                    .frame(height: geometry.size.height * 0.1)
                    //.offset(x: 1 ,y: geometry.size.height * 0.009)
            }
            .scrollContentBackground(.hidden)
            .background(Color.green)
        }
    }
}

struct ImageActionView_Previews: PreviewProvider {
    static var previews: some View {
        ImageActionView(todo: ToDo.init(name: "朝の会", toDoDetails: [ToDoDetail(name: "挨拶", isCheck: false)]), todoDetail: ToDoDetail.init(name: "予定", isCheck: false))
    }
}
