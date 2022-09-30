//
//  EmployeeController.swift
//  SmallBiz
//
//  Created by Matthew Rawlings on 9/26/22.
//

import Foundation

class EmployeeController {
    // Creating single shared instance across code files
    static let shared = EmployeeController()
    // Source of truth!
    var employees: [Employee] = []
    // Datasource for Default Items
    var defaultItems: [String] = [
        "Payroll",
        "Onboarding",
        "Employee Profile",
        "Work shoes",
        ]
    // Create new employee
    func addEmployee(firstName: String, lastName: String) {
        let employee = Employee(firstName: firstName, lastName: lastName, skillLevel: 0, id: 0)
        if UserDefaults.standard.bool(forKey: "New Employee default items") {
            let tasks: [Task] = defaultItems.compactMap( { Task(title: $0) } )
            employee.tasks = tasks
        }
        employees.append(employee)
        saveToPersistentStorage()
    }
    // Delete employee
    func deleteEmployee(employee: Employee) {
        guard let index = employees.firstIndex(of: employee) else { return }
        employees.remove(at: index)
        saveToPersistentStorage()
    }
    // Persistence Storage Location
    func persistentStorage() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Employees.json")
        return fileURL
    }
    
    // Save
    func saveToPersistentStorage() {
        do {
            let data = try JSONEncoder().encode(employees)
            try data.write(to: persistentStorage())
        } catch {
            print("We had an error saving to our persistence store.")
            print(error)
            print(error.localizedDescription)
        }
    }
    // Load
    func loadFromPersistenceStorage() {
        do {
            let data = try Data(contentsOf: persistentStorage())
            employees = try JSONDecoder().decode([Employee].self, from: data)
        } catch {
            print("We had an error loading our data from persistence storage.")
            print(error)
            print(error.localizedDescription)
        }
    }
}
