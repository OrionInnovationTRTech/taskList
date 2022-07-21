//
//  ContentView.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 19.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var tasks: FetchedResults<Tasks>
    @State private var isAddingNewTask: Bool = false
//    @State var title: String = ""
//    @State var detail: String = ""
    @ObservedObject private var td = TaskModel()
    
    var body: some View {
        List{
            ForEach(tasks){ task in
                NavigationLink(destination: TaskDetailView(task:task)){
                    VStack(alignment: .leading){
                        Text(task.title ?? "")
                            .font(.headline)
                        HStack{
                            Text(task.creationDate! ,style: .date)
                            Text(task.detail?.prefix(10) ?? "")
                                + Text("...")
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                }
            }
            .onDelete(perform: deleteTask)
        }
        .navigationTitle("Tasks")
        .toolbar{
            Button {
                td.clear()
                isAddingNewTask.toggle()
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $isAddingNewTask){
            NavigationView{
                addTaskView(title: $td.title, detail: $td.detail)
                    .navigationTitle("Add New Task")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isAddingNewTask.toggle()
                                td.clear()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let task = Tasks(context: moc)
                                task.id = UUID()
                                task.title = td.title
                                task.detail = td.detail
                                task.creationDate = Date.now
                                isAddingNewTask.toggle()
                                try? moc.save()
                            }.disabled(td.isTitleValid() ? false : true)
                        }
                    }
            }
        }
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
        ContentView()
    }
}
