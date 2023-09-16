//
//  ImageActionViewModel.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/13.
//

import Foundation
import SwiftUI
import AVFoundation


class ImageActionViewModel: ObservableObject {
    
    @Published var todo: ToDo
    @Published var todoDetail: ToDoDetail
    @Published var toDos: [ToDo]
    
    private let toDoModel: ToDoModel
    
    init(todo: ToDo, todoDetail: ToDoDetail, toDoModel: ToDoModel) {
        self.todo = todo
        self.todoDetail = todoDetail
        self.toDoModel = toDoModel
        
        toDos = [ToDo(name: "", toDoDetails: [])]

        toDoModel.$toDos
            .assign(to: &$toDos)
    }
    
    //MARK: セルの『👍』アニメーションとセルの背景色（赤・青）の管理を行なっている。
    func isCheckedToChange(todo: ToDo, todoDetail: ToDoDetail){
        toDoModel.isCheckedToChange(todo: todo, todoDetail: todoDetail)
    }
    
    //MARK: 画面右上の『サークル』ボタンメソッド。isCheckedのBoolを全て『false』に切り替える。
    func isCheckedToAllFalse(todo: ToDo){
        toDoModel.isCheckedToAllFalse(todo: todo)
    }
}
