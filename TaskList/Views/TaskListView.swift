//
//  TaskListView.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 19.07.2022.
//

import SwiftUI

struct TaskListView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.creationDate,order: .reverse)]) var tasks: FetchedResults<Tasks>
    @State private var isAddingNewTask: Bool = false
    @StateObject private var taskModel = TaskModel()
    
    var body: some View {
        List{
            ForEach(tasks){ task in
                NavigationLink(destination: TaskDetailView(task:task)){
                    ListItemView(task: task)
                }
                .listRowBackground(Color(UIColor(named: task.backgroundColor!)!))
            }
            .onDelete(perform: deleteTask)
        }
        .navigationTitle("Tasks")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button {
                    taskModel.clear()
                    isAddingNewTask = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddingNewTask){
            NavigationView{
                addTaskView()
                    .navigationTitle("Add New Task")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isAddingNewTask = false
                                taskModel.clear()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                addTask()
                                isAddingNewTask = false
                            }
                            .disabled(taskModel.isTitleValid() ? false : true)
                        }
                    }
            }
        }
        .environmentObject(taskModel)
    }
    
    func addTask(){
        let task = Tasks(context: moc)
        task.id = UUID()
        task.title = taskModel.title
        task.detail = taskModel.detail
        task.creationDate = Date.now
        task.backgroundColor = CustomColors.colorArray.randomElement()
        isAddingNewTask = false
        try? moc.save()
    }
    
    func deleteTask(at offsets: IndexSet){
        for offset in offsets{
            let task = tasks[offset]
            moc.delete(task)
        }
        try? moc.save()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environment(\.managedObjectContext, DataController.shared.container.viewContext)
    }
}
