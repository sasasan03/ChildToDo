//
//  ImgaeActionRowView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/11.
//

import SwiftUI

struct ImgaeActionRowView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    let todoDetail: ToDoDetail
    let todo: ToDo
    
    var body: some View {
        GeometryReader { geometry in
            HStack{
                if todoDetail.isCheck{
                    GoodView()
                        .frame(
                            width: geometry.size.width * 0.2,
                            height: geometry.size.height
                        )
                } else {
                    Image("")
                        .frame(
                            width: geometry.size.width * 0.2,
                            height: geometry.size.height
                        )
                }
                Text(todoDetail.isCheck ?"よくできました" : todoDetail.name)
                    .font(.system(
                        size: geometry.size.width * 0.07,
                        weight: .ultraLight,
                        design: .serif
                    ))
                    .foregroundColor(.black)
                    .rotationEffect(Angle(degrees
                                          : todoDetail.isCheck
                                          ? 360 : 0
                                         ))
                    .animation(.default,value:todoDetail.isCheck)
            }
            .onTapGesture(count: 2) {
                homeViewModel.dTrueChange(todo: todo, todoDetail: todoDetail)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

struct ImgaeActionRowView_Previews: PreviewProvider {
    static var previews: some View {
        ImgaeActionRowView(todoDetail: ToDoDetail(name: "挨拶", isCheck: false), todo: ToDo(name: "帰りの会", toDoDetails: [ToDoDetail(name: "歩く", isCheck: false)]))
    }
}
