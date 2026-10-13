//
//  TaskError.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 10.10.26.
//

import Foundation

enum TaskFlowError: LocalizedError {
    case emptyTitle
    case invalidLink
    
    var errorDescription: String?{
        switch self {
            case .emptyTitle: "Title cannot be empty"
            case .invalidLink: "Please add a valid url"
        }
    }
}
