//
//  TaskListApp.swift
//  TaskList
//
//  Created by Seyit Murat Kaya on 19.07.2022.
//

import SwiftUI

@main
struct TaskListApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                TaskListView()
            }
            .navigationViewStyle(.stack)
            .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
