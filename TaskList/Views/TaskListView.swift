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
    
    var body: some View {
        FilteredTaskListView(filterSetting)
            .navigationTitle("Tasks")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        isAddingNewTask.toggle()
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
                }
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
            .environment(\.managedObjectContext, DataController.shared.container.viewContext)
    }
}
