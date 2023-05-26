//
//  DetailViewModel.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var isShowAddView = false
    
    func isShowDetailAddView(){
        isShowAddView = true
    }
    
    func isCloseDetailAddView(){
        isShowAddView = false
    }
}
