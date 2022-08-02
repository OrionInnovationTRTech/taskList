//
//  TaskListView.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 19.07.2022.
//

import SwiftUI

struct TaskListView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var isAddingNewTask: Bool = false
    @State private var filterSetting: Int = 0
    @StateObject private var taskModel = TaskModel()
    
    var body: some View {
        FilteredTaskListView(filterSetting)
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
                ToolbarItem(placement: .navigationBarLeading){
                    Menu(){
                        Button("Newest"){filterSetting = 0}
                        Button("Oldest"){filterSetting = 1}
                        Button("Alphabetical"){filterSetting = 2}
                        Button("Priority"){filterSetting = 3}
                    } label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
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
        task.backgroundColor = CustomColorEnum.allCases.randomElement()?.rawValue
        task.priority = taskModel.priority.rawValue
        task.priorityNumber = Int16(taskModel.priority.value)
        try? moc.save()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environment(\.managedObjectContext, DataController.shared.container.viewContext)
    }
}
