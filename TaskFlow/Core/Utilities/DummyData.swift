//
//  DummyData.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 11.10.26.
//

import Foundation

extension Task {
    static let samples: [Task] = [
        Task(title: "Buy Groceries", note: "Integral", dueDate: .now),
        Task(title: "Estudar SwiftData", dueDate: .now.addingTimeInterval(86_400 * 2)),
        Task(title: "Ligar para o João", isCompleted: true, priority: .low)
    ]
}
