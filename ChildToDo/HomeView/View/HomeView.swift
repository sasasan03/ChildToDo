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
    let todoDetail: ToDoDetail
    let todo2: ToDo
    var detailViewModel: DetailViewModel {
        return DetailViewModel(sharedHomeViewModel: homeViewModel, todo: selectionTodo!, todoDetail: todoDetail)
    }
    
    var body: some View {
        //MARK: - おおもとのリスト（細かな項目の上位階層のリスト）
        NavigationSplitView(sidebar: {
            List(selection: $selectionTodo) {
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
            //MARK: - 新しい項目を追加するためのシート
            .sheet(isPresented: $homeViewModel.isAddView) {
                ToDoAddView(save: { text in
                    try homeViewModel.addTodo(text: text)
                    dismiss()
                })
            }
            .onAppear(perform: homeViewModel.onApper)
        } , detail:{
            //MARK: - おおもとのリスト内の細かな項目（細かなリスト）
            //MARK: おおもとのリストが選択されている場合
            if let returnTodo =  homeViewModel.returnAdress(todo: selectionTodo){
                let todoDetailIndex = homeViewModel.todoDetailIndex(todo: returnTodo, todoDetail: todoDetail)
                let todoCount = returnTodo.toDoDetails.count
                //MARK: - 細かな項目が設定されている場合の画面
                if todoCount != 0 {
                    ToDoDetailView(todo: returnTodo, todoDetail: returnTodo.toDoDetails[todoDetailIndex])
                        .environmentObject(detailViewModel)
                        .navigationTitle(selectionTodo?.name ?? "やること編集")
                        .toolbarBackground(Color.cyan,for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark)
                } else {
                //MARK: 細かな項目が設定されていない場合の画面
                    ZStack{
                        ToDoDetailView(todo: returnTodo, todoDetail: ToDoDetail(name: "", isChecked: false))
                            .environmentObject(detailViewModel)
                            .navigationTitle(selectionTodo?.name ?? "やること編集")
                            .toolbarBackground(Color.cyan,for: .navigationBar)
                            .toolbarBackground(.visible, for: .navigationBar)
                            .toolbarColorScheme(.dark)
                        Color.cyan
                    }
                }
            } else {
                //MARK: - おおもとのリストが選択されていない場合
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
        HomeView(todoDetail: ToDoDetail(name: "挨拶", isChecked: false), todo2: ToDo(name: "a", toDoDetails: [ToDoDetail(name: "a", isChecked: false)]))
            .environmentObject(HomeViewModel())
    }
}
