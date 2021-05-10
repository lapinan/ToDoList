//
//  TaskCellViewModel.swift
//  CombineToDoList
//
//  Created by Андрей Лапин on 10.05.2021.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    var taskRepository = TaskRepository()
    @Published var task: Task
    
    var id = ""
    @Published var completionStateIconName = ""
    
    private var cancellabels = Set<AnyCancellable>()
    
    init(task: Task) {
        self.task = task
        
        $task
            .map { task in
                task.completed ? "checkmark.circle.fill" : "circle"
            }
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellabels)
        
        $task
            .compactMap { taks in
                task.id
            }
            .assign(to: \.id, on: self)
            .store(in: &cancellabels)
        
        $task
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { task in
                self.taskRepository.updateTask(task)
            }
            .store(in: &cancellabels)
                
    }
}
