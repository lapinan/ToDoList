//
//  TaskListViewModel.swift
//  CombineToDoList
//
//  Created by Андрей Лапин on 10.05.2021.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var taskRepository = TaskRepository()
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellabels = Set<AnyCancellable>()
    
    init() {
            taskRepository  
                .$tasks
                .map { tasks in
                    tasks.map { task in
                        TaskCellViewModel(task: task)
                    }
                }
                .assign(to: \.taskCellViewModels, on: self)
                .store(in: &cancellabels)
    }
    
    func addTask(task: Task) {
        taskRepository.addTask(task)
        taskCellViewModels.append(TaskCellViewModel(task: task))
    }
}
