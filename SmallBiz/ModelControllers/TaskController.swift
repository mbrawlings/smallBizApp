//
//  TaskController.swift
//  SmallBiz
//
//  Created by Matthew Rawlings on 9/27/22.
//

import Foundation

class TaskController {
    // create tasks for employee
    static func assignTaskTo(employee: Employee, taskTitle: String) {
        let newTask = Task(title: taskTitle)
        employee.tasks.append(newTask)
        EmployeeController.shared.saveToPersistentStorage()
    }
    // remove completed tasks
    static func removeTaskFrom(employee: Employee, task: Task) {
        guard let index = employee.tasks.firstIndex(of: task) else { return }
        employee.tasks.remove(at: index)
        print("Successfully removed task from \(employee.firstName)'s list of tasks.")
        EmployeeController.shared.saveToPersistentStorage()
    }
    
    static func toggleTaskStatus(employee: Employee, task: Task) {
//        guard let taskIndex = employee.tasks.firstIndex(of: task),
//              let employeeIndex = EmployeeController.shared.employees.firstIndex(of: employee) else { return }
//
//        EmployeeController.shared.employees[employeeIndex].tasks[taskIndex].isComplete.toggle()
        task.isComplete.toggle()
        EmployeeController.shared.saveToPersistentStorage()
    }
}
