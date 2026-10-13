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
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    
    @State private var showDatePicker = false
    
    
    
    var body: some View {
        @Bindable var vm = viewModel
       
        VStack(spacing: 12){
            
            TextField("new_task", text: $vm.title)
                .focused($isFocused)
            
            HStack(spacing: 16){
                
                Button{
                    showDatePicker.toggle()
                }label: {
                    HStack(spacing: 8){
                        Image(systemName: "calendar")
                        if  let date = viewModel.dueDate {
                            Text(date.formatted(date: .abbreviated, time: .omitted))
                        }
                    }
                }
                .popover(isPresented: $showDatePicker) {
                    DatePicker(
                        "date",
                        selection: Binding(
                            get: { vm.dueDate ?? .now},
                            set: { vm.dueDate = $0}
                        ),
                        displayedComponents: .date
                    )
                    .datePickerStyle(.graphical)
                    .labelsHidden()
                    .frame(width: 320)
                    .padding()
                    .presentationCompactAdaptation(.popover)
                }
                
                Menu {
                    ForEach(TaskPriority.allCases, id: \.self) { priority in
                        Button(priority.rawValue.capitalized) {
                            vm.priority = priority
                        }
                    }
                } label: {
                    
                    if let priority = vm.priority {
                        Label(priority.rawValue.capitalized, systemImage: "flag")
                    } else {
                        Image(systemName: "flag")
                    }
                   
                   
                }
                .frame(width: 120, alignment: .leading)
                
                Spacer()
                
                Button{
                    do {
                        try viewModel.save(to: modelContext)
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
            
        }
        .padding()
        .presentationDetents([.height(120)])
        .presentationDragIndicator(.hidden)
        .onAppear {
            isFocused = true
        }
    }
}


#Preview {
    AddTaskView()
}

