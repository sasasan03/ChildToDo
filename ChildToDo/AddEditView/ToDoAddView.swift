//
//  ToDoAddView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/09.
//

import SwiftUI

struct ToDoAddView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var todo = ""
    @State private var alert = false
    let save: (String) throws -> Void
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack{
                ZStack{
                    Color.gray
                    HStack{
                        Text("追加")
                            .frame(width: geometry.size.width * 0.2)
                            .foregroundColor(Color.white)
                        TextField("", text: $todo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: geometry.size.width * 0.7 )
                    }
                    .padding()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("キャンセル") {
                                dismiss()
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("保存") {
                                do {
                                    try save(todo)
                                    dismiss()
                                } catch {
                                    alert = true
                                }
                            }
                            .alert("エラー", isPresented: $alert) {
                            } message: {
                                let error = NonTextError.nonTodoText.nonTextFieldType
                                Text(error)
                            }
                        }
                    }
                    .toolbarBackground(Color.gray,for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    .toolbarColorScheme(.dark)
                }
            }
        }
    }
}

struct ToDoAddView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoAddView(save: { _ in })
    }
}
