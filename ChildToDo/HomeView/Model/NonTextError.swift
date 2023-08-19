//
//  NonTextError.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation
//MARK: テキストが入力されていない場合にエラーを返すために使用
enum NonTextError: Error {
    case nonTodoText
    case nonTodoDetailText
    case unKnownError
    
    var nonTextFieldType: String {
        switch self {
        case .nonTodoText: return "入力してください"
        case .nonTodoDetailText: return "やることを入力してください"
        case .unKnownError: return "unKnowError"
        }
    }
}
