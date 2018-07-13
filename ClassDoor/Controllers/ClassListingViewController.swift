//
//  ClassListingViewController.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/12/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import UIKit

class ClassListingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum ActivityStatus {
        case Edit
        case View
        case Select(person: PersonClassifiable)
    }

    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
    var dependent: Dependent?
    var classes: [Class] = []
    var activityStatus: ActivityStatus = .View
    weak var previousViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = 100
        self.tableView.estimatedRowHeight = 300
        self.title = "Classes"
        self.tableView.register(ClassTableViewCell.self, forCellReuseIdentifier: "\(ClassTableViewCell.self)")
        
        for i in 1...2 {
            let semaphore = DispatchSemaphore(value: 0)
            BackendDataService.shared.getWithIdentifier(i, type: ClassBackendResource.self) {
                guard let foundClass = $0?.modelObj else {
                    return
                }
                self.classes.append(foundClass)
                semaphore.signal()
            }
            semaphore.wait()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ClassTableViewCell.self)", for: indexPath) as! ClassTableViewCell
        let classItem = self.classes[indexPath.row]
        cell.titleLabel.text = classItem.title
        cell.descriptionLabel.text = classItem.description
        cell.createdByLabel.text = self.user.username
        cell.durationLabel.text = "\(classItem.duration)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let classItem = self.classes[indexPath.row]
        let classVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClassViewController") as! ClassViewController
        classVC.user = self.user
        classVC.activityStatus = .Select(person: self.dependent!)
        BackendDataService.shared.getWithIdentifier(classItem.id!, type: ClassBackendResource.self) {
            guard let foundClass = $0?.modelObj else {
                print("failed to find class!")
                return
            }
            classVC.createdClass = foundClass
            classVC.previousViewController = self.previousViewController
            DispatchQueue.main.async {
                self.navigationController!.popViewController(animated: false)
                self.previousViewController!.navigationController!.pushViewController(classVC, animated: true)
            }
        }
    }
   

}
