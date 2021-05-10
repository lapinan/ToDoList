//
//  TaskListView.swift
//  CombineToDoList
//
//  Created by Андрей Лапин on 10.05.2021.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListViewModel = TaskListViewModel()
    
    private let tasks = testDataTasks
    
    @State private var presentNewTask: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(taskListViewModel.taskCellViewModels) { taskCellViewModel in
                        TaskCell(taskCellViewModel: taskCellViewModel)
                    }
                    
                    if presentNewTask {
                        TaskCell(taskCellViewModel: TaskCellViewModel(task: Task(completed: false, title: ""))) { task in
                            taskListViewModel.addTask(task: task)
                            presentNewTask.toggle()
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                Button(action: {
                    presentNewTask.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text("Add new task")
                    }
                }
                .padding()
            }
            .navigationTitle("Tasks")
        }
    }
}

struct TaskCell: View {
    @ObservedObject var taskCellViewModel: TaskCellViewModel
    
    var onCommit: (Task) -> () = { _ in }
    
    var body: some View {
        HStack {
            Image(systemName: taskCellViewModel.completionStateIconName)
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    taskCellViewModel.task.completed.toggle()
                }
            
            TextField("Enter the task title", text: $taskCellViewModel.task.title, onCommit: {
                onCommit(taskCellViewModel.task)
            })
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
