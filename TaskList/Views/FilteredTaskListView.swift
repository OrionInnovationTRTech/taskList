//
//  FilteredTaskListView.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 28.07.2022.
//

import SwiftUI

struct FilteredTaskListView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest var tasks: FetchedResults<Tasks>
    
    var body: some View {
        List{
            ForEach(tasks){ task in
                NavigationLink(destination: TaskDetailView(task:task)){
                    ListItemView(task: task)
                }
                .listRowBackground(Color(task.backgroundColor ?? "oxblood"))
            }
            .onDelete(perform: deleteTask)
        }
    }
    
    func deleteTask(at offsets: IndexSet){
        for offset in offsets{
            let task = tasks[offset]
            moc.delete(task)
        }
        try? moc.save()
    }
    
    init(_ filter: Int){
        switch filter{
        case 0:
            _tasks = FetchRequest<Tasks>(sortDescriptors: [SortDescriptor(\.creationDate,order: .reverse)])
        case 1:
            _tasks = FetchRequest<Tasks>(sortDescriptors: [SortDescriptor(\.creationDate,order: .forward)])
        case 2:
            _tasks = FetchRequest<Tasks>(sortDescriptors: [SortDescriptor(\.title,order: .forward)])
        case 3:
            _tasks = FetchRequest<Tasks>(sortDescriptors: [SortDescriptor(\.priorityNumber,order: .reverse)])
        default:
            _tasks = FetchRequest<Tasks>(sortDescriptors: [SortDescriptor(\.creationDate,order: .reverse)])
        }
    }
}

//struct FilteredTaskListView_Previews: PreviewProvider {
//    static var previews: some View {
//        FilteredTaskListView()
//    }
//}
