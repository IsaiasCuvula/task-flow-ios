//
//  TaskLink.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 12.10.26.
//

import Foundation
import SwiftData


@Model
final class TaskLink {
    var link: String
    var createdAt: Date
    var task: Task?
    
    init(link: String, createdAt: Date = .now) {
        self.link = link
        self.createdAt = createdAt
    }
}
