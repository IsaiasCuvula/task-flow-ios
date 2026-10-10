//
//  TaskError.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 10.10.26.
//

import Foundation

enum TaskError: LocalizedError {
    case emptyTitle
    
    var errorDescription: String?{
        switch self {
            case .emptyTitle: "Title cannot be empty"
        }
    }
}
