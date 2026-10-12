//
//  AddTaskLinkView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 12.10.26.
//

import SwiftUI
import SwiftData

struct AddTaskLinkView: View {
    let task: Task
    @FocusState private var isFocused: Bool
    @State private var viewModel = AddTaskLinkViewModel()
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        @Bindable var vm = viewModel
        
        VStack(spacing: 12) {
            TextField("link", text: $vm.link)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .keyboardType(.URL)
                .focused($isFocused)
                .padding(.trailing, 44)
                .overlay(alignment: .trailing) {
                    Button{
                        do {
                            try viewModel.addLink(
                                to: task,modelContext:  modelContext
                            )
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
//    AddTaskLinkView()
//}
