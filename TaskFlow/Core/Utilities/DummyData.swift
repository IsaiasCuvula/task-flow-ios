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
        Task(title: "Study SwiftData", dueDate: .now.addingTimeInterval(86_400 * 2)),
        Task(title: "Call my brother John", note: "Call John and tell him you missing him a lot", priority: .low)
    ]
}
