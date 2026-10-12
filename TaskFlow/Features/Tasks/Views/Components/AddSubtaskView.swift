//
//  AddSubtaskView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 12.10.26.
//

import SwiftUI
import SwiftData

struct AddSubtaskView: View {
    let task: Task
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel: SubtasksViewModel = SubtasksViewModel()
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        @Bindable var vm = viewModel
        
        VStack(spacing: 12) {
            TextField("new_task", text: $vm.title)
                .focused($isFocused)
                .padding(.trailing, 44)
                .overlay(alignment: .trailing) {
                    Button{
                        do {
                            try viewModel.addSubtask(to: task,
                                modelContext:  modelContext)
                            dismiss()
                        }catch {
                            print("\(error.localizedDescription)")
                        }
                    }label: {
                        Image(systemName: "arrow.up")
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                    .disabled(!viewModel.isValid)
                }
        
            
        } .padding()
            .presentationDetents([.height(100)])
            .presentationDragIndicator(.hidden)
            .onAppear {
                isFocused = true
            }
        
        
    }
}

//#Preview {
//    AddSubtaskView()
//}
