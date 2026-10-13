//
//  CalendarViewModel.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 14.10.26.
//

import SwiftData
import Foundation


@Observable
final class CalendarViewModel {
    
    func tasksByDate(tasks: [Task], date: Date) -> [Task]{
        let calendar = Calendar.current
        
        return  tasks.filter{task in
            guard let due = task.dueDate else {return false}
            return calendar.isDate(due, inSameDayAs: date)
        }.sorted { task1, task2 in
            (task1.dueDate ?? .distantFuture) < (task2.dueDate ?? .distantFuture)
        }
    }
}
