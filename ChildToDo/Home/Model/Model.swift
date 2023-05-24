//
//  Model.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation
import SwiftUI
import AVFoundation

//------------------------Model??ViewModel??
let crappingHands = try! AVAudioPlayer(data: NSDataAsset(name: "clappingHands")!.data)

public func playSoundCorrect(){
    crappingHands.stop()
    crappingHands.currentTime = 0.0
    crappingHands.play()
}
//------------------------

struct ToDoDetail: Identifiable, Hashable, Codable  {
    var id = UUID()
    var name: String
    var isCheck: Bool
    
    func unchecked() -> ToDoDetail {
        let todoDetail =  ToDoDetail(id: id, name: name, isCheck: false)
        return todoDetail
    }
}

struct ToDo: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var toDoDetails: [ToDoDetail]
    
    func unchecked() -> ToDo {
         let toDo =  ToDo(id: id, name: name, toDoDetails: toDoDetails.map{ $0.unchecked() })
        return toDo
    }
}

extension Array where Element == ToDo {
    func unchecked() -> [ToDo]{
      let arrayMap =  self.map{ todo in todo }
        return arrayMap
    }
}
