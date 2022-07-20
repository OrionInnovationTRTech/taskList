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
    
    var body: some View {
        List{
            ForEach(tasks){ task in
                Text("deneme")
            }
            .onDelete(perform: deleteTask)
        }
        .navigationTitle("Tasks")
        .toolbar{
            Button {
                let task = Tasks(context: moc)
                task.id = UUID()
                task.title = "title"
                task.detail = "detail"
                task.creationDate = Date.now
                try? moc.save()
            } label: {
                Image(systemName: "plus")
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
