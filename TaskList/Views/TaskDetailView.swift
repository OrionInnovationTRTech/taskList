//
//  TaskDetailView.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 20.07.2022.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @ObservedObject var task:Tasks
    @StateObject var taskModel = TaskModel()
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack{
            TextField("",text: $taskModel.title)
                .font(.largeTitle)
            Divider()
            TextEditor(text: $taskModel.detail)
        }
        .padding()
        .navigationTitle(Text(task.creationDate ?? Date.now,style: .date))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .confirmationAction) {
                Button() {
                    showDeleteAlert = true
                } label: {
                    Label("Delete",systemImage: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .alert("Delete Task",isPresented: $showDeleteAlert){
            Button("Delete",role: .destructive,action: deleteTask)
            Button("Cancel",role: .cancel){ }
        } message : {
            Text("Are you sure?")
        }
        .onAppear(){
            taskModel.title = task.title ?? ""
            taskModel.detail = task.detail ?? ""
        }
        .onDisappear(){
            task.title = taskModel.title
            task.detail = taskModel.detail
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
    
    func deleteTask(){
        moc.delete(task)
        dismiss()
    }
}
//
//struct TaskDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskDetailView()
//    }
//}
