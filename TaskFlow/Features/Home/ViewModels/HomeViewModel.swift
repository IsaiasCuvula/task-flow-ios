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
    
    func nonUrgentTasks(tasks: [Task]) -> [Task]{
      return  tasks.filter{task in
          task.priority != TaskPriority.high
        }.sorted { task1, task2 in
            task1.dueDate ?? .now < task2.dueDate ?? .now
        }
    }
}
