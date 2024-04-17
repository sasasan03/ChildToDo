//
//  ContentView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel: HomeViewModel
    @StateObject var detailViewModel: DetailViewModel
    @StateObject var imageActionViewModel: ImageActionViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectionTodo: ToDo?
    let todoDetail: ToDoDetail
    let todoModel: ToDoModel
    let todo: ToDo
    
    init(todoDetail: ToDoDetail, todoModel: ToDoModel, todo: ToDo) {
        self._homeViewModel = StateObject(wrappedValue: HomeViewModel(toDoModel: todoModel))
        self._detailViewModel = StateObject(wrappedValue: DetailViewModel(todo: todo, todoDetail: todoDetail, toDoModel: todoModel))
        self._imageActionViewModel = StateObject(wrappedValue: ImageActionViewModel(todo: todo, todoDetail: todoDetail, toDoModel: todoModel))
        self.todoDetail = todoDetail
        self.todoModel = todoModel
        self.todo = todo
    }
    
    var body: some View {
        // やることリスト(題名)
        NavigationSplitView(sidebar: {
            List(selection: $selectionTodo) {
                ForEach(homeViewModel.toDos){ todo in
                    HomeRowView(todoModel: todoModel, todo: todo)
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
            // 新しいやることリストを追加（題名追加）
            .sheet(isPresented: $homeViewModel.isAddView) {
                ToDoAddView(save: { text in
                    try homeViewModel.addTodo(text: text)
                    dismiss()
                })
            }
            .onAppear(perform: todoModel.onApper)
        } ,
                            detail:{
            // 題名のTODOの詳細リスト
            // 題名をタップしたときにそのアドレスを返す。
            if let returnTodo = homeViewModel.returnAdress(todo: selectionTodo) {
                let todoDetailIndex = homeViewModel.todoDetailIndex(todo: returnTodo, todoDetail: todoDetail)
                let todoCount = returnTodo.toDoDetails.count
                // 題名のTODOが設定されている場合に表示される（todoのcountが１以上）
                if todoCount != 0 {
                    ToDoDetailView(todo: returnTodo, todoDetail: returnTodo.toDoDetails[todoDetailIndex], todoModel: todoModel)
                        .navigationTitle(selectionTodo?.name ?? "やること編集")
                        .toolbarBackground(Color.cyan,for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark)
                } else {
                    // 題名のTODOが設定されていない場合に表示される（todoのcountが0）
                    ZStack{
                        ToDoDetailView(
                            todo: returnTodo,
                            todoDetail: todoDetail,
                            todoModel: todoModel
                        ).navigationTitle(selectionTodo?.name ?? "やること編集")
                            .toolbarBackground(Color.cyan,for: .navigationBar)
                            .toolbarBackground(.visible, for: .navigationBar)
                            .toolbarColorScheme(.dark)
                        Color.cyan
                    }
                }
            } else {
                //Todoを選んでいない初期画面（🐘象が出てくる画面）
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
        HomeView(
            todoDetail: ToDoDetail(name: "服の着替え", isChecked: true),
            todoModel: ToDoModel(),
            todo: ToDo(name: "に", toDoDetails: [ToDoDetail(name: "ぬ", isChecked: true)])
        )
    }
}
