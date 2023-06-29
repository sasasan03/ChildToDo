//  ImageActionView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct ImageActionView: View {
    //Viewの生成時のみ
    @EnvironmentObject var homeViewModel: HomeViewModel
    let todo: ToDo
    
    var body: some View {
        GeometryReader { geometry in
            List(todo.toDoDetails) { todoD in
                ImgaeActionRowView(todoDetail: todoD)
                    .background(todoD.isChecked ? Color.ligthOrange : Color.ligthBlue)
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
                            playSoundCorrect()
                        }
                        homeViewModel.dChange(todo: todo, todoDetail: todoD)
                    }
            }
            //MARK: - 画面右上リセットボタン
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        homeViewModel.todoDetailFalse(todo: todo)
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

