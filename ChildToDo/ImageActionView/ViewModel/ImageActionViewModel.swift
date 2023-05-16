//
//  ImageActionViewModel.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/13.
//

import Foundation
import SwiftUI
import AVFoundation


class ImageActionViewModel {
    
    private let crappingHands = try! AVAudioPlayer(data: NSDataAsset(name: "clappingHands")!.data)
    
    public func playSoundCorrect(){
        crappingHands.stop()
        crappingHands.currentTime = 0.0
        crappingHands.play()
    }
}
