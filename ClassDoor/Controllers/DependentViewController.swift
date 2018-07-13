//
//  DependentViewController.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/12/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import UIKit

class DependentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum ActivityStatus: String {
        case Edit
        case View
    }
    
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var user: User!
    var dependent: Dependent?
    var activityStatus: ActivityStatus = .View
    var doneButton: UIBarButtonItem!
    var editButton: UIBarButtonItem!
    weak var previousViewController: UIViewController?
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, h:mm a"
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.register(UINib(nibName: "\(ClassSessionTableViewCell.self)", bundle: nil), forCellReuseIdentifier: "\(ClassSessionTableViewCell.self)")
        
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEditing(_:)))
        self.editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(beginEditing(_:)))
        self.configureNavigationBar()
        self.configureTextFields()
        self.initializeTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if let profileVC = self.previousViewController as? ProfileViewController {
            profileVC.user = self.user
        }
    }
    
    func loadData() {
        guard let dependentID  = self.dependent?.id else {
            return
        }
        
        var partialEnrollments: [Enrollment] = []
        let sem = DispatchSemaphore(value: 0)
        BackendDataService.shared.getWithIdentifier(dependentID, type: DependentBackendResource.self) {
            guard let foundDependent = $0?.modelObj, let enrollments = foundDependent .enrollments else {
                sem.signal()
                return
            }
            partialEnrollments = enrollments
            sem.signal()
        }
        sem.wait()
        
        var fullEnrollments: [Enrollment] = []
        for var enrollment in partialEnrollments {
            BackendDataService.shared.getWithIdentifier(enrollment.classSessionID, type: ClassSessionBackendResource.self ) {
                guard let foundClassSession  = $0?.modelObj else {
                    sem.signal()
                    return
                }
                enrollment.classSession = foundClassSession
                fullEnrollments.append(enrollment)
                sem.signal()
            }
            sem.wait()
        }
        self.dependent?.enrollments = fullEnrollments
        self.tableView.reloadData()
    }
    
    func configureNavigationBar() {
        switch self.activityStatus {
        case .Edit:
            self.navigationItem.rightBarButtonItem = self.doneButton
            self.navigationItem.title = self.dependent == nil ? "Adding new dependent" : self.navigationItem.title
        case .View:
            self.navigationItem.rightBarButtonItem = self.editButton
            self.navigationItem.title = self.dependent != nil ? "\(self.dependent!.firstname) \(self.dependent!.lastname)" : ""
        }
    }
    
    func configureTextFields() {
        switch self.activityStatus {
        case .Edit:
            self.firstnameTextField.isUserInteractionEnabled = true
            self.lastnameTextField.isUserInteractionEnabled = true
        case .View:
            self.firstnameTextField.isUserInteractionEnabled = false
            self.lastnameTextField.isUserInteractionEnabled = false
        }
    }
    
    func initializeTextFields() {
        self.firstnameTextField.text = self.dependent?.firstname
        self.lastnameTextField.text = self.dependent?.lastname
    }
    
    @objc func doneEditing(_ sender: UIBarButtonItem) {
        self.activityStatus = .View
        self.configureNavigationBar()
        self.configureTextFields()
        if self.dependent == nil {
            self.saveNewDependent()
        } else {
            self.patchExistingDependent()
        }
    }
    
    @IBAction func onEnrollButtonTapped(_ sender: UIButton) {
        let classListingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClassListingViewController") as! ClassListingViewController
        classListingVC.user = self.user
        classListingVC.dependent = self.dependent
        classListingVC.activityStatus = .Select(person: self.dependent!)
        classListingVC.previousViewController = self
        self.navigationController?.pushViewController(classListingVC, animated: true)
    }
    
    @objc func beginEditing(_ sender: UIBarButtonItem) {
        self.activityStatus = .Edit
        self.configureNavigationBar()
        self.configureTextFields()
    }
    
    func saveNewDependent() {
        if self.dependent != nil {
            print("dependent is being modified not created!")
            return
        }
        guard let firstname = self.firstnameTextField.text, let lastname = self.lastnameTextField.text else {
            print("Invalid firstname or lastname!")
            return
        }
        let dependent = Dependent(firstname: firstname, lastname: lastname, dependencyID: self.user!.id!)
        BackendDataService.shared.save(DependentBackendResource(of: dependent)) {
            guard let newDependent = $0?.modelObj else {
                print("failed to create dependent with firstname \(dependent.firstname) and lastname \(dependent.lastname)")
                return
            }
            self.dependent = newDependent
            if self.user.dependents != nil {
                self.user.dependents?.append(newDependent)
            } else {
                self.user.dependents = [newDependent]
            }
            print("Successfully created new dependent by user \(self.user!.username)")
            DispatchQueue.main.async {
                self.configureNavigationBar()
            }
        }
    }
    
    func patchExistingDependent() {
        guard var oldDependent = self.dependent else {
            print("the dependent to patch is nil!")
            return
        }
        guard let firstname = self.firstnameTextField.text, let lastname = self.lastnameTextField.text else {
            print("Invalid firstname or lastname!")
            return
        }
        if firstname == oldDependent.firstname && lastname == oldDependent.lastname {
            print("no change has been made to the dependent!")
            return
        }
        let patchDataDict = ["firstname": firstname, "lastname": lastname]
        BackendDataService.shared.patchWithID(oldDependent.id!, type: DependentBackendResource.self, data: patchDataDict) {
            guard let newDependent = $0?.modelObj else {
                print("failed to patch dependent \(oldDependent.id!) with firstname \(firstname) and lastname \(lastname)")
                return
            }
            self.dependent?.firstname = newDependent.firstname
            self.dependent?.lastname = newDependent.lastname
            print("Successfully patched dependent \(oldDependent.id!)")
            DispatchQueue.main.async {
                self.configureNavigationBar()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dependent?.enrollments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ClassSessionTableViewCell.self)", for: indexPath) as! ClassSessionTableViewCell
        cell.classTitleLabelEqualHeightsConstraint.isActive = false
        cell.classTitleLabelHeightConstraint.isActive = true
        guard let enrollment = self.dependent?.enrollments?[indexPath.row], let classSession = enrollment.classSession else {
            return cell
        }
        
        BackendDataService.shared.getWithIdentifier(classSession.scheduleID, type: ScheduleBackendResource.self) {
            guard let foundSchedule = $0?.modelObj else {
                return
            }
            BackendDataService.shared.getWithIdentifier(classSession.classID, type: ClassBackendResource.self) {
                guard let foundClass = $0?.modelObj else {
                    return
                }
                let firstTimeslot = foundSchedule.baseTimeslots?.first
                DispatchQueue.main.async {
                    cell.classTitleLabel.text = foundClass.title
                    cell.startTimeLabel.text = self.dateFormatter.string(from: firstTimeslot!.startAt)
                    cell.endTimeLabel.text = foundSchedule.repeatEndAt != nil ? self.dateFormatter.string(from: foundSchedule.repeatEndAt!) : ""
                    cell.repeatOptionLabel.text = String(foundSchedule.repeatOption.rawValue.split(separator: ".")[1])
                    cell.durationLabel.text = "\(firstTimeslot!.duration)"
                    cell.numOfEnrollmentsLabel.text = "\(classSession.enrollments!.count)"
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var enrollmentsCount = 0
        if let enrollments = self.dependent?.enrollments {
             enrollmentsCount = enrollments.count
        }
        switch enrollmentsCount {
        case 0:
            return  "Not enrolled in any class session"
        case 1:
             return  "Enrolled in 1 class session"
        default:
             return  "Enrolled in \(enrollmentsCount) class sessions"
        }
    }

}
