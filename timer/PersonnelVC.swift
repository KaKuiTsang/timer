//
//  PersonnelVC.swift
//  timer
//
//  Created by Tsang Ka Kui on 25/7/2018.
//  Copyright © 2018年 Tsang Ka Kui. All rights reserved.
//

import UIKit

final class PersonnelVC: UITableViewController {
    
    private let sections = [ "Name", "Age", "Position", "Address"]
    
    private let info = ["Tsang Ka Kui", "28", "iOS Developer", "Wong Tai Sin"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Personal Info"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(dismissVC))
        
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.register(InfoCell.self, forCellReuseIdentifier: InfoCell.identifier)
        tableView.register(InfoHeader.self, forHeaderFooterViewReuseIdentifier: InfoHeader.identifier)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier) as! InfoCell
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.text = info[indexPath.section]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: InfoHeader.identifier) as! InfoHeader
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.text = sections[section]
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

}


final class InfoCell: UITableViewCell {
    
    static let identifier = String(describing: self)
    
}

final class InfoHeader: UITableViewHeaderFooterView {
    
    static let identifier = String(describing: self)
    
}
