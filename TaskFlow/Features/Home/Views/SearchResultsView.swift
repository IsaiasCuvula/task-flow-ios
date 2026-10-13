//
//  SearchResultsView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 14.10.26.
//

import SwiftUI

struct SearchResultsView: View {
    let tasks: [Task]
    let searchText: String
    @Binding var selectedTask: Task?

    private var results: [Task] {
        guard !searchText.isEmpty else { return [] }
        return tasks.filter { task in
            task.title.localizedStandardContains(searchText) ||
            (task.note?.localizedStandardContains(searchText) ?? false)
        }
    }

    var body: some View {
        List(results) { task in
            TaskTileView(task: task, onTap: { selectedTask = task })
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .overlay {
            if results.isEmpty {
                ContentUnavailableView.search(text: searchText)
            }
        }
    }
}

