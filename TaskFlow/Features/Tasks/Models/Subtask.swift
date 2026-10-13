//
//  Subtask.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 12.10.26.
//

import Foundation
import SwiftData


@Model
final class Subtask{
    var title: String
    var isCompleted: Bool = false
    var createdAt: Date
    var task: Task?
    
    init(title: String, isCompleted: Bool = false, createdAt: Date = .now) {
        self.title = title
        self.isCompleted = isCompleted
        self.createdAt = createdAt
    }
}
