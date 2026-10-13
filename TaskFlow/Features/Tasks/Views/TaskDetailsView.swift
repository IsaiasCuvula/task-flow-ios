//
//  EditTaskView.swift
//  TaskFlow
//
//  Created by Isaias Cuvula on 11.10.26.
//

import SwiftUI
import SwiftData

struct TaskDetailsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @Bindable var task: Task
    
    @State private var showAddSubtask: Bool = false
    @State private var showAddTaskLink: Bool = false
  
    
    var body: some View {
        NavigationStack{
            
            ScrollView {
                VStack(spacing: 16){
                    HStack(spacing: 8){
                        TextField(task.title, text: $task.title, axis: .vertical)
                            .font(.title2.weight(.semibold))
                            .lineLimit(1...3)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        Text("priority")
                        
                        Spacer()
                        
                        Picker("priority", selection: $task.priority) {
                            ForEach(TaskPriority.allCases, id: \.self){ priority in
                                Text(priority.rawValue.capitalized)
                                    .tag(priority)
                            }
                        }
                    }
                    
                    HStack{
                        Text("date")
                        Spacer()
                        if task.dueDate != nil {
                            DatePicker("date", selection: Binding(
                                get: {task.dueDate ?? .now},
                                set: {task.dueDate = $0 }
                                ),displayedComponents: .date
                            )
                            .labelsHidden()
                        } else {
                            Button("select_date"){
                                task.dueDate = .now
                            }
                        }
                    }
                    
                    Section("Note"){
                        TextField("note", text:  Binding(
                            get: {task.note ?? ""},
                            set: {task.note = $0 }
                        ), axis: .vertical)
                        .font(.footnote.weight(.light))
                            .lineLimit(1...4)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    Divider()
                    
                    HStack{
                        Text("subtasks")
                            .font(.title3.weight(.semibold))
                        
                        Spacer()
                        
                        Button{
                            withAnimation {
                                showAddSubtask.toggle()
                            }
                        }label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                        
                    }.frame(maxWidth: .infinity)
                        .padding(.bottom)
                    
                    SubtasksListView(task: task)
                    
                    Divider()
                    
                    HStack{
                        Text("links")
                            .font(.title3.weight(.semibold))
                        
                        Spacer()
                        
                        Button{
                            showAddTaskLink.toggle()
                        }label: {
                            Image(systemName: "plus")
                        }
                        .buttonStyle(.plain)
                    }.frame(maxWidth: .infinity)
                        .padding(.bottom)
                    
                    TaskLinksView(task: task)
                    
                    
                    
                }.padding()
                
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button{
                        dismiss()
                    } label :{
                        
                        Image(systemName: "xmark")
                        
                    }.buttonBorderShape(.circle)
                }
                
                ToolbarItem(placement: .destructiveAction) {
                    Button{
                        withAnimation {
                            modelContext.delete(task)
                            dismiss()
                        }
                    } label :{
                        Image(systemName: "trash")
                        
                    }.buttonBorderShape(.circle)
                }
            }
            .sheet(isPresented: $showAddSubtask) {
                AddSubtaskView(task: task)
            }
            .sheet(isPresented: $showAddTaskLink) {
                AddTaskLinkView(task: task)
            }
            
        }
    }
}

#Preview {
    TaskDetailsView(task: Task.samples.first!)
}
