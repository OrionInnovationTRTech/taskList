//
//  TaskDetailView.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 20.07.2022.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var task:Tasks
//    @Binding var newTaskTitle: String
//    @Binding var newTaskDetail: String
    @ObservedObject private var td = TaskModel()
    @State var isEditing = false
    
    var body: some View {
        VStack{
            Form{
                Section(header:Text("Title")){
                    Text(task.title ?? "")
                }
                Section(header: Text("Details")){
                    Text(task.detail ?? "")
                }
            }
        }
        .navigationTitle(Text(task.creationDate ?? Date.now,style: .date))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .confirmationAction) {
                Button("Edit") {
                    isEditing = true
                    td.title = task.title ?? ""
                    td.detail = task.detail ?? ""
                }
            }
        }
        .sheet(isPresented: $isEditing){
            NavigationView{
                addTaskView(title: $td.title, detail: $td.detail)
                    .navigationTitle("Edit Task")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isEditing = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                task.title = td.title
                                task.detail = td.detail
                                try? moc.save()
                                isEditing = false
                            }
                        }
                    }
            }
        }
    }
}

//struct TaskDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskDetailView()
//    }
//}
