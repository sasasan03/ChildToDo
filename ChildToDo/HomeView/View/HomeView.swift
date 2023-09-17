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
        //MARK: - おおもとのリスト（細かな項目の上位階層のリスト）
        NavigationSplitView(sidebar: {
            List(selection: $selectionTodo) {
                ForEach(homeViewModel.toDos){ todo in
                    HomeRowView(todoModel: todoModel, todo: todo)
//                        HomeRowView(
//                            homeViewModel: homeViewModel,
//                            todoModel: todoModel,
//                            todo: todo
//                        )
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
            .onAppear(perform: todoModel.onApper)
        } , detail:{
            //MARK: - TodoDetailのリスト部分（Todoの細かな詳細項目）
            if let returnTodo = homeViewModel.returnAdress(todo: selectionTodo){
                let todoDetailIndex = homeViewModel.todoDetailIndex(todo: returnTodo, todoDetail: todoDetail)
                let todoCount = returnTodo.toDoDetails.count
            //MARK: - TodoDetailが入力されている場合の画面設定
                if todoCount != 0 {
//                    ToDoDetailView(detailViewModel: detailViewModel, imageActionViewModel: imageActionViewModel, todo: returnTodo, todoDetail: todoDetail, todoModel: todoModel)
                    ToDoDetailView(todo: todo, todoDetail: todoDetail, todoModel: todoModel)
                        .navigationTitle(selectionTodo?.name ?? "やること編集")
                        .toolbarBackground(Color.cyan,for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark)
                } else {
                //MARK: TodoDetaileが空の場合の画面設定
                    ZStack{
//                        ToDoDetailView(detailViewModel: detailViewModel, imageActionViewModel: imageActionViewModel, todo: returnTodo, todoDetail: todoDetail, todoModel: todoModel)
                        ToDoDetailView(todo: todo, todoDetail: todoDetail, todoModel: todoModel)
//                        ToDoDetailView(todo: returnTodo, todoDetail: ToDoDetail(name: "", isChecked: false))
                            .navigationTitle(selectionTodo?.name ?? "やること編集")
                            .toolbarBackground(Color.cyan,for: .navigationBar)
                            .toolbarBackground(.visible, for: .navigationBar)
                            .toolbarColorScheme(.dark)
                        Color.cyan
                    }
                }
            } else {
                //MARK: - TodoDetailが選択されていない場合（🐘象が出てくる画面）
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

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(
//            viewModel: HomeViewModel(toDoModel: ToDoModel()),
//            todoDetail: ToDoDetail(name: "", isChecked: false),
//            todoModel: ToDoModel()
//        )
//    }
//}
