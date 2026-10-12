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
    
    
    
    func addLink(to task: Task, modelContext: ModelContext) throws {
        
        guard isValid  else {
            throw TaskFlowError.invalidLink
        }
        
        let normalizedURL = getNormalizedURL(link: link)
        
        if normalizedURL == nil {
            throw TaskFlowError.invalidLink
        }
        
        let link = TaskLink(link: normalizedURL?.absoluteString ?? "")
        link.task = task
        
        modelContext.insert(link)
        try modelContext.save()
        
    }
    
    var isValid: Bool {
        !link.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    private func getNormalizedURL(link: String) -> URL? {
        var text = link.trimmingCharacters(in: .whitespacesAndNewlines)
           guard !text.isEmpty else { return nil }

           if let match = text.firstMatch(of: /\]\((.+?)\)/) {
               text = String(match.1)
           }

           if !text.contains("://") {
               text = "https://\(text)"
           }

           guard
               let url = URL(string: text),
               let scheme = url.scheme?.lowercased(),
               ["http", "https"].contains(scheme),
               let host = url.host(),
               !host.isEmpty
           else { return nil }

           return url
    }
    
}
