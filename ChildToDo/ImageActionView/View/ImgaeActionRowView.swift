//
//  ImgaeActionRowView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/11.
//
import Foundation
import SwiftUI

struct ImgaeActionRowView: View {
    
    @EnvironmentObject var detailViewModel: DetailViewModel
    let todoDetail: ToDoDetail
    
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
                //MARK: -『よくできました』と『入力された項目』
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

struct ImgaeActionRowView_Previews: PreviewProvider {
    static var previews: some View {
        ImgaeActionRowView(todoDetail: ToDoDetail(name: "挨拶", isChecked: false))
    }
}
