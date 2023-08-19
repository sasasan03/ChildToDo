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
    
    @Published var sharedDetailViewModel: DetailViewModel
    @Published var todo: ToDo
    @Published var todoDetail: ToDoDetail
    
    init(sharedDetailViewModel: DetailViewModel, todo: ToDo, todoDetail: ToDoDetail) {
        self.sharedDetailViewModel = sharedDetailViewModel
        self.todo = todo
        self.todoDetail = todoDetail
    }
    
    var toDos: [ToDo]{
        sharedDetailViewModel.toDos
    }
    
    func dChange(todo: ToDo, todoDetail: ToDoDetail){
        guard let tIndex = sharedDetailViewModel.toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        guard let dIndex = todo.toDoDetails.firstIndex(where: { $0.id == todoDetail.id }) else { return }
        sharedDetailViewModel.sharedHomeViewModel.toDos[tIndex].toDoDetails[dIndex].isChecked.toggle()
    }
    
    func todoDetailFalse(todo: ToDo){
        guard let tIndex = sharedDetailViewModel.toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        sharedDetailViewModel.toDos[tIndex].toDoDetails.forEach{ _ in
            (0..<sharedDetailViewModel.toDos[tIndex].toDoDetails.count).forEach{
                sharedDetailViewModel.sharedHomeViewModel.toDos[tIndex].toDoDetails[$0].isChecked = false
            }
        }
    }
    
    private let crappingHands = try! AVAudioPlayer(data: NSDataAsset(name: "clappingHands")!.data)
    
    public func playSoundCorrect(){
        crappingHands.stop()
        crappingHands.currentTime = 0.0
        crappingHands.play()
    }
}
