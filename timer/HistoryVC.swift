//
//  HistoryVC.swift
//  timer
//
//  Created by Tsang Ka Kui on 25/7/2018.
//  Copyright © 2018年 Tsang Ka Kui. All rights reserved.
//

import UIKit

struct Task {
    let name: String
    let timeSpent: String
}

final class HistoryVC: UITableViewController {

    var tasks = [ Task(name: "11111111111111111111111111111111111111111111111111111111111111111111111111111111", timeSpent: "01 : 00"), Task(name: "2", timeSpent: "01 : 00"), Task(name: "3", timeSpent: "01 : 00") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks History"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(dismissVC))
        
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.identifier)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.identifier) as! HistoryCell
        cell.setUpCell(task: task)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
}

final class HistoryCell: UITableViewCell {
    static let identifier = String(describing: self)
    
    private let nameLabel = UILabel()
    
    private let timeLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.textColor = UIColor.black
        timeLabel.textColor = UIColor.black
        timeLabel.textAlignment = .right
        
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        nameLabel.lineBreakMode = .byTruncatingTail
        
        self.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpCell(task: Task) {
        nameLabel.text = task.name
        timeLabel.text = task.timeSpent
    }
}



