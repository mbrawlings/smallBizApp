//
//  Employee.swift
//  SmallBiz
//
//  Created by Matthew Rawlings on 9/26/22.
//

import Foundation

class Employee: Codable {
    let firstName: String
    let lastName: String
    var skillLevel: Int = 0
    var id: Int = 0
    var tasks: [Task] = []
    
    init(firstName: String, lastName: String, skillLevel: Int, id: Int, tasks: [Task] = []) {
        self.firstName = firstName
        self.lastName = lastName
        self.skillLevel = skillLevel
        self.id = id
        self.tasks = tasks
    }
}

extension Employee: Equatable {
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
}
