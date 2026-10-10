//
//  AddTaskView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 10.10.26.
//

import SwiftUI
import SwiftData

struct AddTaskView: View {
    
    @Environment(\.modelContext) private  var modelContext
    @State private var viewModel: AddTaskViewModel = AddTaskViewModel()
    
    
    var body: some View {
        Text("add_task")
        Button {
            
        } label: {
            Text("save")
        }
    }
}

