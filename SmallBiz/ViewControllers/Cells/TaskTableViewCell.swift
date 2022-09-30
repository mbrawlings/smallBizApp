//
//  TaskTableViewCell.swift
//  SmallBiz
//
//  Created by Matthew Rawlings on 9/28/22.
//

import UIKit

    // STEP 1: Defining the protocol
protocol TaskStatusChangedProtocol: AnyObject {
    func updateTaskStatus(task: Task)
}

struct CellImages {
    static let incomplete: UIImage = UIImage(systemName: "circle")!
    static let complete: UIImage = UIImage(systemName: "circle.inset.filled")!
}

class TaskTableViewCell: UITableViewCell {
    
    var task: Task! {
        didSet {
            updateViews()
        }
    }
    //MARK: - Outlets
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskButton: UIButton!
    
    //STEP 2: Creating property for protocol
    weak var delegate: TaskStatusChangedProtocol?
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //MARK: - Action
    @IBAction func doneButtonTapped(_ sender: Any) {
        //STEP 3 call the delegate
        delegate?.updateTaskStatus(task: task)
    }
    
    //MARK: - Helper Functions
    func updateViews() {
        taskTitleLabel.text = task.title
        taskButton.setImage(task.isComplete ? CellImages.complete : CellImages.incomplete, for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
