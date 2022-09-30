//
//  ViewController.swift
//  SmallBiz
//
//  Created by Colton Swapp on 8/26/22.
//

import UIKit

class EmployeesListViewController: UIViewController {
    
//    var employee: Employee?
    
    //MARK: - View Outlets
    @IBOutlet weak var addEmployeeTextField: UITextField!
    @IBOutlet weak var newEmployeeTableView: UITableView!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewTitle()
        EmployeeController.shared.loadFromPersistenceStorage()
    }

    //MARK: - Action Outlets
    @IBAction func addNewEmployeeButtonTapped(_ sender: Any) {
        guard let employeeFullName = addEmployeeTextField.text,
              !employeeFullName.isEmpty else { return }
        let firstThenLast = employeeFullName.components(separatedBy: " ")
        EmployeeController.shared.addEmployee(firstName: firstThenLast[0], lastName: firstThenLast[1])
        addEmployeeTextField.text = ""
        newEmployeeTableView.reloadData()
    }
    
    //MARK: - Helper Functions
    func setupTableView() {
        newEmployeeTableView.delegate = self
        newEmployeeTableView.dataSource = self
    }
    func setupViewTitle() {
        navigationItem.title = "Employees"
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // IIDOO
         if segue.identifier == "toEmployeeTask" {
             guard let indexPath = newEmployeeTableView.indexPathForSelectedRow,
                   let destination = segue.destination as? EmployeeTaskListViewController else {return}
             let employeeToSend = EmployeeController.shared.employees[indexPath.row]
             destination.employee = employeeToSend
        }
    }
}

    //MARK: - Table View Extension
extension EmployeesListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        EmployeeController.shared.employees.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath)
        let employee = EmployeeController.shared.employees[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(employee.firstName) \(employee.lastName)"
        cell.contentConfiguration = content
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let employeeToDelete = EmployeeController.shared.employees[indexPath.row]
            EmployeeController.shared.deleteEmployee(employee: employeeToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}




