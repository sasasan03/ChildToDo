//
//  ToDoEditView.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/09.
//

import SwiftUI

struct ToDoEditView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var todoName: String
    @State private var alert = false
    let edit: (String) throws -> Void
    
    
    var body: some View {
        NavigationStack{
            GeometryReader { geometry in
                ZStack{
                    Color.gray
                    HStack{
                        Text("変更")
                            .frame(width: geometry.size.width * 0.2)
                            .foregroundColor(.white)
                        TextField("", text: $todoName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: geometry.size.width * 0.7)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading){
                            Button("cancel") {
                                dismiss()
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("save") {
                                do {
                                   try edit(todoName)
                                    dismiss()
                                } catch {
                                    alert = true
                                    let error = error as? NonTextError ?? NonTextError.unKnownError
                                    print(">>空っす",error.nonTextFieldType)
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


struct ToDoEditView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoEditView(todoName: "一日の時間割", edit: { _ in })
    }
}
