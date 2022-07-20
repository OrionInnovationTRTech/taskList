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
    @Binding var newTaskTitle: String
    @Binding var newTaskDetail: String
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
//            Text("Creation date: ")
//                + Text(task.creationDate! ,style: .date)
        }
        .navigationTitle("lsjdf")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .confirmationAction) {
                Button("Edit") {
                    isEditing = true
                    newTaskTitle = task.title ?? ""
                    newTaskDetail = task.detail ?? ""
                }
            }
        }
        .sheet(isPresented: $isEditing){
            NavigationView{
                addTaskView(title: $newTaskTitle, detail: $newTaskDetail)
                    .navigationTitle("Edit Task")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isEditing = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                task.title = newTaskTitle
                                task.detail = newTaskDetail
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
