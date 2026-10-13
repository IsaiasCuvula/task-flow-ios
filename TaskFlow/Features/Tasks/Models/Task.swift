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
    var dueDate: Date?
    var priority: TaskPriority
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade, inverse: \Subtask.task)
    var subtasks: [Subtask] = []
    
    @Relationship(deleteRule: .cascade, inverse: \TaskLink.task)
    var links: [TaskLink] = []
    
    
    init(title: String,note: String? = nil, dueDate: Date? = nil, priority: TaskPriority = .medium) {
        self.title = title
        self.note = note
        self.dueDate = dueDate
        self.priority = priority
        self.createdAt = .now
    }
    
     var progress: Double {
        guard !subtasks.isEmpty else { return 0 }
        return Double(subtasks.filter(\.isCompleted).count) / Double(subtasks.count)
    }
    
    var daysLeft: Int? {
        guard let dueDate else { return nil }
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let due = calendar.startOfDay(for: dueDate)
        return calendar.dateComponents([.day], from: today, to: due).day
    }
}
