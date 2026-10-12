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
    var priority: TaskPriority?  = nil
    
    
    var isValid: Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    
    func save(to context: ModelContext) throws {
        
        guard isValid else {
            throw TaskFlowError.emptyTitle
        }
        
        let newTask = Task(title: title)
        
        if let p = priority{
            newTask.priority = p
        }
        
        if(!note.trimmingCharacters(in: .whitespaces).isEmpty){
            newTask.note = note
        }
        
        if let dueDate {
            newTask.dueDate = dueDate
        }
        
        context.insert(newTask)
    }
    
}
