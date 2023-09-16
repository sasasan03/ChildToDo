//
//  ContentView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectionTodo: ToDo?
    let todoDetail: ToDoDetail
    let todoModel: ToDoModel
    
    init(viewModel: HomeViewModel, selectionTodo: ToDo? = nil, todoDetail: ToDoDetail, todoModel: ToDoModel) {
        self._viewModel = StateObject(wrappedValue: HomeViewModel(toDoModel: todoModel))
        self.todoDetail = todoDetail
        self.todoModel = todoModel
    }
    
    var body: some View {
        //MARK: - おおもとのリスト（細かな項目の上位階層のリスト）
        NavigationSplitView(sidebar: {
            List(selection: $selectionTodo) {
                ForEach(viewModel.toDos){ todo in
                        HomeRowView(
                            todo: todo
                        )
                        .foregroundColor(.black)
                    }
                    .onDelete(perform: viewModel.deleteTodo(offset:))
                    .onMove(perform: viewModel.moveTodo(indexSet:index:))
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
                        viewModel.isShowAddView()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            //MARK: - 新しい項目を追加するためのシート
            .sheet(isPresented: $viewModel.isAddView) {
                ToDoAddView(save: { text in
                    try viewModel.addTodo(text: text)
                    dismiss()
                })
            }
            .onAppear(perform: todoModel.onApper)
        } , detail:{
            //MARK: - TodoDetailのリスト部分（Todoの細かな詳細項目）
            if let returnTodo = viewModel.returnAdress(todo: selectionTodo){
                let todoDetailIndex = viewModel.todoDetailIndex(todo: returnTodo, todoDetail: todoDetail)
                let todoCount = returnTodo.toDoDetails.count
            //MARK: - TodoDetailが入力されている場合の画面設定
                if todoCount != 0 {
                    ToDoDetailView(todo: returnTodo, todoDetail: returnTodo.toDoDetails[todoDetailIndex])
//                        .environmentObject(detailViewModel)
                        .navigationTitle(selectionTodo?.name ?? "やること編集")
                        .toolbarBackground(Color.cyan,for: .navigationBar)
                        .toolbarBackground(.visible, for: .navigationBar)
                        .toolbarColorScheme(.dark)
                } else {
                //MARK: TodoDetaileが空の場合の画面設定
                    ZStack{
                        ToDoDetailView(todo: returnTodo, todoDetail: ToDoDetail(name: "", isChecked: false))
//                            .environmentObject(detailViewModel)
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            viewModel: HomeViewModel(toDoModel: ToDoModel()),
            todoDetail: ToDoDetail(name: "", isChecked: false),
            todoModel: ToDoModel()
        )
    }
}
