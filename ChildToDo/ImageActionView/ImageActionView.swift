//
//  ImageActionView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct ImageActionView: View {
    //Viewの生成時のみ
    @EnvironmentObject var homeViewModel: HomeViewModel
    let imageActionViewModel = ImageActionViewModel()
    let todo: ToDo
    let todoDetail: ToDoDetail
    
    var body: some View {
        GeometryReader { geometry in
            List(homeViewModel.toDos.first(where: { $0.name == todo.name })?.toDoDetails ?? [] ) { todoD in
                ImgaeActionRowView(todoDetail: todoD, todo: todo)
                    .background(todoD.isCheck ? Color.ligthOrange : Color.ligthBlue)
                    .frame(height: geometry.size.height * 0.1)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
//-----------------------🟥boolを全て切り替える。
                        homeViewModel.toDos = homeViewModel.toDos.map{ toDo -> ToDo in
                            var details: [ToDoDetail] = []
                            toDo.toDoDetails.forEach{ d in
                                var detail = ToDoDetail(name: d.name, isCheck: false)
                                detail.id = d.id
                                print("確認detail",detail.isCheck)
                                details.append(detail)
                            }
                            var newToDo = ToDo(name: toDo.name, toDoDetails: details)
                            newToDo.id = toDo.id
                            print("確認②",newToDo)
                            return newToDo
                        }
////----------------------------------🟥
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
        ImageActionView(todo: ToDo.init(name: "朝の会", toDoDetails: [ToDoDetail(name: "校長のとてもとても長い話", isCheck: false)]), todoDetail: ToDoDetail.init(name: "予定", isCheck: false))
    }
}
//"校長のめちゃくちゃ長い話"１０文字
// "校長のとてもとても長い話"10文字ともに１０文字以上は表示できない

