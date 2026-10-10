//
//  Task.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 10.10.26.
//

import Foundation
import SwiftData



@Model
final class Task{
    var title: String
    var note: String?
    var isCompleted: Bool
    var dueDate: Date?
    var priority: TaskPriority
    var createdAt: Date
    
    
    init(title: String,note: String? = nil, isCompleted: Bool = false, dueDate: Date? = nil, priority: TaskPriority = .medium) {
        self.title = title
        self.note = note
        self.isCompleted = isCompleted
        self.dueDate = dueDate
        self.priority = priority
        self.createdAt = .now
    }
}
