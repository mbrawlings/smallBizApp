//
//  EmployeeTaskListViewController.swift
//  SmallBiz
//
//  Created by Matthew Rawlings on 9/27/22.
//

import UIKit

class EmployeeTaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Landing Property
    var employee: Employee!

    //MARK: - Outlets
    @IBOutlet weak var newTaskTextField: UITextField!
    @IBOutlet weak var taskTableView: UITableView!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.dataSource = self
        taskTableView.delegate = self
        setupViewTitle()
    }
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        guard let newTask = newTaskTextField.text,
              !newTask.isEmpty else { return }
        TaskController.assignTaskTo(employee: employee, taskTitle: newTask)
        newTaskTextField.text = ""
        newTaskTextField.resignFirstResponder() // This will close the keyboard after submitting
        taskTableView.reloadData()
    }
    
    //MARK: - Helper Functions
    func setupViewTitle() {
        navigationItem.title = "\(employee.firstName)'s Tasks"
    }
    
    //MARK: - Table View Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employee.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell()}
        
        let task = employee.tasks[indexPath.row]
        cell.task = task // simply passing task info for custom cell to handle
        
        //STEP 4: Tell delegate where action should happen after interaction
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = employee.tasks[indexPath.row]
            TaskController.removeTaskFrom(employee: employee, task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    /*
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
         // IIDOO
         if segue.identifier == "toEmployeeTask" {
             guard let indexPath = newEmployeeTableView.indexPathForSelectedRow,
                   
        }
    }
    */

}

extension EmployeeTaskListViewController: TaskStatusChangedProtocol {
    func updateTaskStatus(task: Task) {
        TaskController.toggleTaskStatus(employee: employee, task: task)
        taskTableView.reloadData()
    }
}
