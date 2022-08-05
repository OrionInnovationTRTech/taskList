//
//  addTaskView.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 20.07.2022.
//

import SwiftUI

struct addTaskView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @StateObject private var taskModel = TaskModel()
    
    
    var body: some View {
        Form{
            Section(header:Text("Title")){
                TextField("Enter Task", text:$taskModel.title)
            }
            Section(header: Text("Details")){
                TextEditor(text:$taskModel.detail)
            }
            Section(header: Text("Priority")){
                Picker("Priority",selection: $taskModel.priority){
                    Text("Low").tag(Priority.low)
                    Text("Medium").tag(Priority.medium)
                    Text("High").tag(Priority.high)
                }
                .pickerStyle(.segmented)
            }
            Section(header: Text("Color")){
                Picker("Colors",selection: $taskModel.backgroundColor){
                    ForEach(CustomColor.allCases){ color in
                        HStack{
                            Image(systemName: "circle.fill")
                                .foregroundColor(Color(color.rawValue))
                            Text(color.rawValue)
                        }
                        .tag(color)
                    }
                }
            }
        }
        .navigationTitle("Add New Task")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Dismiss") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Add") {
                    taskModel.addTask(context: moc)
                    dismiss()
                }
                .disabled(taskModel.title.isEmpty ? true : false)
            }
        }
    }
}

struct addTaskView_Previews: PreviewProvider {
    static var previews: some View {
        addTaskView()
    }
}
