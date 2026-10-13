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
    
    init() {
        func rounded(_ style: UIFont.TextStyle, bold: Bool = false) -> UIFont {
            var descriptor = UIFont.preferredFont(forTextStyle: style).fontDescriptor
            if bold { descriptor = descriptor.withSymbolicTraits(.traitBold) ?? descriptor }
            descriptor = descriptor.withDesign(.rounded) ?? descriptor
            return UIFont(descriptor: descriptor, size: 0)  
        }

        UINavigationBar.appearance().largeTitleTextAttributes = [.font: rounded(.largeTitle, bold: true)]
        UINavigationBar.appearance().titleTextAttributes = [.font: rounded(.headline)]
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: [Task.self, Subtask.self, TaskLink.self])
    }
}
