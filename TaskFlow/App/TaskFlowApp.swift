//
//  TaskFlowApp.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 8.10.26.
//

import SwiftUI
import SwiftData

@main
struct TaskFlowApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .fontDesign(.rounded)
        }
        .modelContainer(for: [Task.self, Subtask.self, TaskLink.self])
    }
}
