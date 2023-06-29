//
//  ChildToDoApp.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

@main
struct ChildToDoApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(todoDetail: ToDoDetail(name: "挨拶", isChecked: false))
                .environmentObject(HomeViewModel())
        }
    }
}
