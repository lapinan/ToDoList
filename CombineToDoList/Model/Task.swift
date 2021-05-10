//
//  Task.swift
//  CombineToDoList
//
//  Created by Андрей Лапин on 10.05.2021.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Task: Codable, Identifiable {
    @DocumentID var id: String?
    var completed: Bool
    var title: String
    @ServerTimestamp var createdTime: Timestamp?
}

let testDataTasks =  [
    Task(completed: true, title: "Implement the UI"),
    Task(completed: false, title: "Connect to Firebase"),
    Task(completed: false, title: "????"),
    Task(completed: false, title: "Profit!!")
]
