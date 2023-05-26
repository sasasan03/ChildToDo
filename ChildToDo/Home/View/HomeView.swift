//
//  ContentView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectionTodo: ToDo?
    @State private var isEdit = false
    let todoDetail: ToDoDetail
    let todo: ToDo
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List(selection: $selectionTodo) {
                let _ = print("🟥HomeView",homeViewModel.toDos[0].toDoDetails[0].isCheck)
                ForEach(homeViewModel.toDos){ todo in
                        HomeRowView(
                            todo: todo
                        )
                        .foregroundColor(.black)
                    }
                    .onDelete(perform: homeViewModel.deleteTodo(offset:))
                    .onMove(perform: homeViewModel.moveTodo(indexSet:index:))
                }
                .scrollContentBackground(.hidden)
                .background(Color.purple)
                .navigationTitle("やることリスト")
                .toolbarBackground(Color.purple, for: .navigationBar)
                .toolbarBackground(Color.purple,for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        homeViewModel.isShowAddView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $homeViewModel.isAddView) {
                ToDoAddView(save: { text in
                    try homeViewModel.addTodo(text: text)
                    dismiss()
                })
            }
            .onAppear(perform: homeViewModel.onApper)
        } , detail:{
            //Todoに入っている配列の要素を表示
            if let returnTodo =  homeViewModel.returnAdress(todo: selectionTodo){
                let todoDetailIndex = homeViewModel.todoDetailIndex(todo: returnTodo, todoDetail: todoDetail)
                let todoCount = returnTodo.toDoDetails.count
                if todoCount != 0 {
                    ToDoDetailView(todo: returnTodo, todoDetail: returnTodo.toDoDetails[todoDetailIndex])
                        .navigationTitle(selectionTodo?.name ?? "やること編集")
                        .toolbarBackground(Color.cyan,for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark)
                } else {
                    ZStack{
                        ToDoDetailView(todo: returnTodo, todoDetail: ToDoDetail(name: "", isCheck: false))
                                .navigationTitle(selectionTodo?.name ?? "やること編集")
                                .toolbarBackground(Color.cyan,for: .navigationBar)
                                .toolbarBackground(.visible, for: .navigationBar)
                                .toolbarColorScheme(.dark)
                        Color.cyan
                    }
                
                }
            } else {
                ZStack{
                    Color.orange
                        .ignoresSafeArea()
                    VStack{
                        Text("選択されるのを待ってます.....")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                        LottieView(resourceType: .loading)
                    }
                }
            }
        }
        )
        .accentColor(Color.white)
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(todoDetail: ToDoDetail(name: "挨拶", isCheck: false), todo: ToDo(name: "朝の会", toDoDetails: [ToDoDetail(name: "予定", isCheck: false)]))
            .environmentObject(HomeViewModel())
    }
}
