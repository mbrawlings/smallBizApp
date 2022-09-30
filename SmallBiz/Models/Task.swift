//
//  Task.swift
//  SmallBiz
//
//  Created by Matthew Rawlings on 9/27/22.
//

import Foundation

class Task: Codable {
    let title: String
    var isComplete: Bool
    let id: String
    
    init(title: String, isComplete: Bool = false, id: String = UUID().uuidString) {
        self.title = title
        self.isComplete = isComplete
        self.id = id
    }
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
}
