//  ImageActionView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct ImageActionView: View {
    
    @EnvironmentObject var imageActoionViewModel: ImageActionViewModel
    let todo: ToDo
    
    //TODO: 文字数に制限をいれて表示の限界を決める
    //現状１０文字以上の文字は潰れてしまう。
    var body: some View {
        GeometryReader { geometry in
            List(todo.toDoDetails) { todoD in
                ImgaeActionRowView(todoDetail: todoD)
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
                        imageActoionViewModel.isCheckedToChange(todo: todo, todoDetail: todoD)
                    }
            }
            //MARK: - 画面右上リセットボタン
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        imageActoionViewModel.isCheckedToAllFalse(todo: todo)
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
            todo: ToDo(
                name: "朝の会",
                toDoDetails: [ToDoDetail(name: "あいさつ", isChecked: true)]
            )
        )
    }
}
