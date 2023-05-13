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
            List(todo.toDoDetails) { todoD in
                ImgaeActionRowView(todoDetail: todoD, todo: todo)
                    .background(todoD.isCheck ? Color.ligthOrange : Color.ligthBlue)
                    .frame(height: geometry.size.height * 0.1)
                   // .frame(height: 0.1)
                   // .offset(x: 0 ,y: geometry.size.height * 0.02)
//                    .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("aaaa")
                    } label: {
                        Image(systemName: "plus")
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
        ImageActionView(todo: ToDo.init(name: "朝の会", toDoDetails: [ToDoDetail(name: "校長のめちゃくちゃ長い話", isCheck: false)]), todoDetail: ToDoDetail.init(name: "予定", isCheck: false))
    }
}
