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
    @State private var todo: ToDo? = nil
    let todoDetail: ToDoDetail
    
    var body: some View {
        NavigationSplitView(sidebar: {
                List(selection: $selectionTodo) {
                    ForEach(homeViewModel.toDos){ todo in
                        HomeRowView(
                            todo: todo,
                            update: { newTodo in
                                homeViewModel.update(newTodo: newTodo)
                            }
                        )
                    }
                    .onDelete(perform: homeViewModel.deleteTodo(offset:))
                    .onMove(perform: homeViewModel.moveTodo(indexSet:index:))
                }
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
        }, detail:{
            if let returnTodo =  homeViewModel.returnAdress(todo: selectionTodo){
                let todoDetailIndex = homeViewModel.todoDetailIndex(todo: returnTodo, todoDetail: todoDetail)
                let todoCount = returnTodo.toDoDetails.count
                if todoCount != 0 {
                    ToDoDetailView(todo: returnTodo, todoDetail: returnTodo.toDoDetails[todoDetailIndex])
                } else {
                    ToDoDetailView(todo: returnTodo, todoDetail: ToDoDetail(name: ""))
                }
//                NavigationLink("アニメーションプラス") {
//                    PokemonCheckView(pokemons: pokemonTrainer.pokemons)
//                }
            } else {
                Text("やること")
            }
        }
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView( todoDetail: ToDoDetail(name: "挨拶"))
    }
}
