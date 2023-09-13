//
//  DataConvertError.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation

enum DataConvertError: Error {
    case encodingError
    case decodingError
    case dataGetError
    case dataCorrupted
    case unknown
    
    var title: String {
        switch self {
        case .encodingError:
            return "エンコードエラー"
        case .decodingError:
            return "デコードエラー"
        case .dataGetError:
            return "データ取得失敗"
        case .dataCorrupted:
            return "データが破損"
        default:
            return "不明なエラー"
        }
    }
}
