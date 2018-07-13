//
//  ProfileViewController.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum Section: String {
        case Dependents
        case Classes
    }
    
    class SectionHeaderView: UIView {
        var section: Section?
        var createButton: UIButton
        var sectionLabel: UILabel
        
        override init(frame: CGRect) {
            self.sectionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.createButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            super.init(frame: frame)
            self.setup()
        }
        required init?(coder aDecoder: NSCoder) {
            self.sectionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.createButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            super.init(coder: aDecoder)
            self.setup()
        }
         init(section: Section) {
            self.sectionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.createButton = UIButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.section = section
            self.setup()
        }
        func setup() {
//            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
            self.addSubview(self.sectionLabel)
            self.addSubview(self.createButton)
            self.setupSectionLabel()
            self.setupCreateButton()
        }
        func setupSectionLabel() {
            self.sectionLabel.translatesAutoresizingMaskIntoConstraints = false
            self.sectionLabel.text = self.section!.rawValue
            self.addConstraint(NSLayoutConstraint(item: self.sectionLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 8))
            self.addConstraint(NSLayoutConstraint(item: self.sectionLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: self.sectionLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100))
        }
        
        func setupCreateButton() {
            self.createButton.translatesAutoresizingMaskIntoConstraints = false
            self.createButton.setTitle("Add", for: .normal)
            self.createButton.setTitleColor(UIColor(red: 99/255, green: 157/255, blue: 157/255, alpha: 1), for: .normal)
            self.addConstraint(NSLayoutConstraint(item: self.createButton, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10))
            self.addConstraint(NSLayoutConstraint(item: self.createButton, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        }
    }
    
    class DependentCell: UITableViewCell {
        var nameLabel: UILabel
        var profilePhotoView: UIImageView
        required init?(coder aDecoder: NSCoder) {
            self.nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.profilePhotoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            super.init(coder: aDecoder)
            self.setup()
        }
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            self.nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            self.profilePhotoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.setup()
        }
        func setup() {
//            self.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(self.nameLabel)
            self.contentView.addSubview(self.profilePhotoView)
            self.setupProfilePhotoView()
            self.setupNameLabel()
        }
        func setupProfilePhotoView() {
            self.profilePhotoView.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraint(NSLayoutConstraint(item: self.profilePhotoView, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 8))
            self.addConstraint(NSLayoutConstraint(item: self.profilePhotoView, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 5))
            self.addConstraint(NSLayoutConstraint(item: self.profilePhotoView, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: -5))
            self.addConstraint(NSLayoutConstraint(item: self.profilePhotoView, attribute:.width , relatedBy: .equal, toItem: self.profilePhotoView, attribute: .height, multiplier: 1, constant: 0))
        }
        func setupNameLabel() {
            self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
            self.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .leading, relatedBy: .equal, toItem: self.profilePhotoView, attribute: .trailing, multiplier: 1, constant: 8))
            self.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: self.nameLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 150))
        }
    }
        

    @IBOutlet weak var tableView: UITableView!

    var sections: [Section] = [.Classes, .Dependents]
    var sectionHeaderViewDict: [Section: SectionHeaderView] = [:]
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = 100
        self.tableView.estimatedRowHeight = 300
        self.title = self.user.username
        self.tableView.register(DependentCell.self, forCellReuseIdentifier: "\(DependentCell.self)")
        self.tableView.register(ClassTableViewCell.self, forCellReuseIdentifier: "\(ClassTableViewCell.self)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func getHeaderViewForSectionAtIndex(_ sectionIndex: Int) -> SectionHeaderView {
        let headerView: SectionHeaderView
        let section = self.sections[sectionIndex]
        if let storedHeaderView = self.sectionHeaderViewDict[section] {
            headerView = storedHeaderView
        } else {
            headerView = SectionHeaderView(section: section)
            switch section {
            case .Dependents:
                headerView.createButton.addTarget(self, action: #selector(onDependentSectionCreateButtonTapped(_:)), for: .touchUpInside)
            case .Classes:
                headerView.createButton.addTarget(self, action: #selector(onClassSectionCreateButtonTapped(_:)), for: .touchUpInside)
            }
            self.sectionHeaderViewDict[section] = headerView
        }
        return headerView
    }
    
    @objc func onDependentSectionCreateButtonTapped(_ sender: UIButton) {
        print("Dependents section create button was just tapped")
        let dependentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DependentViewController") as! DependentViewController
        dependentVC.user = self.user
        dependentVC.activityStatus = .Edit
        dependentVC.previousViewController = self
        self.navigationController!.pushViewController(dependentVC, animated: true)
    }
    
    @objc func onClassSectionCreateButtonTapped(_ sender: UIButton) {
        print("Class section create button was just tapped")
        let classVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClassViewController") as! ClassViewController
        classVC.user = self.user
        classVC.activityStatus = .Edit
        classVC.previousViewController = self
        self.navigationController!.pushViewController(classVC, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.sections[section] {
        case .Dependents:
            return self.user.dependents?.count ?? 0
        case .Classes:
            return self.user.createdClasses?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.getHeaderViewForSectionAtIndex(section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.sections[indexPath.section] {
        case .Dependents:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(DependentCell.self)", for: indexPath) as! DependentCell
            guard let dependent = self.user.dependents?[indexPath.row] else {
                return cell
            }
            cell.nameLabel.text = "\(dependent.firstname) \(dependent.lastname)"
            cell.profilePhotoView.image = UIImage(named: "adela")
            return cell
        case .Classes:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ClassTableViewCell.self)", for: indexPath) as! ClassTableViewCell
            guard let createdClass = self.user.createdClasses?[indexPath.row] else {
                return cell
            }
            cell.titleLabel.text = "title:  \(createdClass.title)"
            cell.descriptionLabel.text = "description:  \(createdClass.description)"
            cell.createdByLabel.text = "created by:  \(self.user.firstname!) \(self.user.lastname!)"
            cell.durationLabel.text = "duration:  \(createdClass.duration)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.sections[indexPath.section] {
        case .Classes:
            guard let createdClass = self.user.createdClasses?[indexPath.row] else {
                return
            }
            let classVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClassViewController") as! ClassViewController
            classVC.user = self.user
            classVC.activityStatus = .View
            classVC.previousViewController = self
            BackendDataService.shared.getWithIdentifier(createdClass.id!, type: ClassBackendResource.self) {
                guard let foundClass = $0?.modelObj else {
                    print("failed to find class!")
                    return
                }
                classVC.createdClass = foundClass
                DispatchQueue.main.async {
                    self.navigationController!.pushViewController(classVC, animated: true)
                }
            }
        case .Dependents:
            let dependentVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DependentViewController") as! DependentViewController
            dependentVC.user = self.user
            dependentVC.activityStatus = .View
            dependentVC.previousViewController = self
            dependentVC.dependent = self.user.dependents?[indexPath.row]
            self.navigationController!.pushViewController(dependentVC, animated: true)
        }
    }
    
}
