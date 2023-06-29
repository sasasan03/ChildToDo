//
//  UserDefaultManager.swift
//  ChildToDo
//
//  Created by sako0602 on 2023/05/08.
//

import Foundation

class UserDefaultManager {
    private let userDefault = UserDefaults.standard
    private var key = "key"
    
    func save(toDo: [ToDo]) throws {
        do {
            let json = try encode(toDo: toDo)
            userDefault.set(json, forKey: key)
        } catch {
            switch error as? DataConvertError ?? DataConvertError.unknown {
            case .encodingError:
                throw DataConvertError.encodingError
            case .dataCorrupted:
                throw DataConvertError.dataCorrupted
            default:
                throw DataConvertError.unknown
            }
        }
    }
    
    func load() throws -> [ToDo] {
        guard let json = userDefault.string(forKey: key) else {
            throw DataConvertError.dataGetError
        }
        do {
            let todos = try decode(json: json)
            return todos
        } catch {
            switch error as? DataConvertError ?? DataConvertError.unknown {
            case .decodingError:
                throw DataConvertError.decodingError
            case .dataCorrupted:
                throw DataConvertError.dataCorrupted
            default:
                throw DataConvertError.unknown
            }
        }
    }
    
    private func decode(json: String) throws -> [ToDo] {
        do {
            guard let data = json.data(using: .utf8) else {
                throw DataConvertError.decodingError
            }
            let todos = try JSONDecoder().decode([ToDo].self, from: data)
            return todos
        } catch {
            throw DataConvertError.decodingError
        }
    }
    
    private func encode(toDo: [ToDo]) throws -> String {
        do {
            let data = try JSONEncoder().encode(toDo)
            guard let json = String(data: data, encoding: .utf8) else {
                throw DataConvertError.dataCorrupted
            }
            return json
        } catch {
            throw DataConvertError.encodingError
        }
    }
}
    

