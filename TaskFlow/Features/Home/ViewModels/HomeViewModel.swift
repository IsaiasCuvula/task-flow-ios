//
//  HomeViewModel.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 13.10.26.
//

import Foundation
import SwiftData


@Observable
final class HomeViewModel{
    
    func tasksByPriority(tasks: [Task], priority: TaskPriority) -> [Task]{
      return  tasks.filter{task in
          task.priority != priority
        }.sorted { task1, task2 in
            task1.dueDate ?? .now < task2.dueDate ?? .now
        }
    }
}
