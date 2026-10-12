//
//  AddTaskLinkViewModel.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 12.10.26.
//

import Foundation
import SwiftData


@Observable
final class AddTaskLinkViewModel{
    var link: String = ""
    
    
    var isValid: Bool {
        !link.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    
    func addLink(to task: Task, modelContext: ModelContext) throws {
        
        guard isValid  else {
            
            throw TaskFlowError.invalidLink
            
        }
        let link = TaskLink(link: link)
        link.task = task
        
        modelContext.insert(link)
        try modelContext.save()
        
    }
}
