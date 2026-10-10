//
//  AddTaskViewModel.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 10.10.26.
//

import Foundation
import SwiftData


@Observable
final class AddTaskViewModel {
    var title = ""
    var note = ""
    var dueDate: Date? = nil
    var priority: TaskPriority = .medium
    
    
    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    
    func save(to context: ModelContext) throws {
        
        guard isValid else {
            throw TaskError.emptyTitle
        }
        
        let newTask = Task(title: title, priority: priority)
        
        if(!note.trimmingCharacters(in: .whitespaces).isEmpty){
            newTask.note = note
        }
        
        if let dueDate {
            newTask.dueDate = dueDate
        }
        
        context.insert(newTask)
    }
    
}
