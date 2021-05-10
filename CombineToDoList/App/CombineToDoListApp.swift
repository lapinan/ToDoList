//
//  CombineToDoListApp.swift
//  CombineToDoList
//
//  Created by Андрей Лапин on 10.05.2021.
//

import SwiftUI
import Firebase

@main
struct CombineToDoListApp: App {
    
    init() {
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
    }
    
    var body: some Scene {
        WindowGroup {
            TaskListView()
        }
    }
}
