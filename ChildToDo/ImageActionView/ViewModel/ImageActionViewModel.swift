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
    init(todo: ToDo, todoDetail: ToDoDetail) {
        self.todo = todo
        self.todoDetail = todoDetail
    }
    
    func dChange(todo: ToDo, todoDetail: ToDoDetail){
        guard let tIndex = toDos.firstIndex(where: { $0.id == todo.id }) else { return }
        guard let dIndex = todo.toDoDetails.firstIndex(where: { $0.id == todoDetail.id }) else { return }
        toDos[tIndex].toDoDetails[dIndex].isChecked.toggle()
    }
    
    private let crappingHands = try! AVAudioPlayer(data: NSDataAsset(name: "clappingHands")!.data)
    
    public func playSoundCorrect(){
        crappingHands.stop()
        crappingHands.currentTime = 0.0
        crappingHands.play()
    }
}
