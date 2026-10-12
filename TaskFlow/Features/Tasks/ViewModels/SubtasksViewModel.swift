//
//  TasksViewModel.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 10.10.26.
//

import Foundation
import SwiftData

@Observable
final class SubtasksViewModel {
    var title: String = ""
    
    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func addSubtask(to task: Task, modelContext: ModelContext) throws {
        
        guard isValid else {
            throw TaskFlowError.emptyTitle
        }
        
        let subtask = Subtask(title: title)
        
        subtask.task = task
        
        modelContext.insert(subtask)
        try modelContext.save()
    }
   
    
    
}
