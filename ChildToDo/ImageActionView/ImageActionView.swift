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
                let _ = print(">>>TodoDetail", todoD)
                ImgaeActionRowView(todoDetail: todoD, todo: todo)
                    .background(todoD.isCheck ? Color.ligthOrange : Color.ligthBlue)
                    .frame(height: geometry.size.height * 0.1)
                    .rotationEffect(Angle(degrees
                                          : todoD.isCheck
                                          ? 360 : 0
                                         )
                    )
                    .animation(.default,value:todoD.isCheck)
                    .onTapGesture(count: 2) {
                        if !todoD.isCheck {
                            playSoundCorrect()
                        }
                        homeViewModel.dChange(todo: todo, todoDetail: todoD)
                    }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        guard let tIndex = homeViewModel.toDos.firstIndex(where: { $0.id == todo.id }) else { return }
                        homeViewModel.toDos[tIndex].toDoDetails.forEach { todoDetail -> [ToDoDetail] in
                            var newTodoDetails:[ToDoDetail] = []
                            newTodoDetails.append(todoDetail.unchecked())
                            return newTodoDetails
                        }
                        //-----------------------🟥
//                        homeViewModel.toDos = homeViewModel.toDos.map{ toDo -> ToDo in
//                            var details: [ToDoDetail] = []
//                            toDo.toDoDetails.forEach{ d in
//                                var detail = ToDoDetail(name: d.name, isCheck: false)
//                                //print(">>>beforeDetailID",detail.id)
//                                detail.id = d.id
//                               // print("<<<afterDetailID",detail.id)
//                                details.append(detail)
//                            }
//                            var newToDo = ToDo(name: toDo.name, toDoDetails: details)
//                            newToDo.id = toDo.id
//                            return newToDo
//                        }
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

//
//struct ImageActionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageActionView(todo: ToDo.init(name: "朝の会", toDoDetails: [ToDoDetail(name: "校長のとてもとても長い話", isCheck: false)]), todoDetail: ToDoDetail.init(name: "予定", isCheck: false))
//    }
//}
//"校長のめちゃくちゃ長い話"１０文字
// "校長のとてもとても長い話"10文字ともに１０文字以上は表示できない

