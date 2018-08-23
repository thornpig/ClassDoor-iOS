//
//  ClassViewController.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/5/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum ActivityStatus {
        case Edit
        case View
        case Select(person: PersonClassifiable)
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var numOfLPSTextField: UITextField!
    @IBOutlet weak var capacityTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    var doneButton: UIBarButtonItem!
    var editButton: UIBarButtonItem!
    weak var previousViewController: UIViewController?
    
    var user: User!
    var createdClass: Class?
    var activityStatus: ActivityStatus = .View
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
        guard let sessions = self.createdClass?.sessions else {
            return
        }
        BackendDataService.shared.getWithIdentifiers(sessions.map{$0.id!}, type: ClassSessionBackendResource.self) {
            self.createdClass?.sessions = $0
            self.tableView.reloadData()
        }
    }
    

    @IBAction func onAddSessionButtonTapped(_ sender: UIButton) {
        let classSessionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClassSessionViewController") as! ClassSessionViewController
        classSessionVC.user = self.user
        classSessionVC.parentClass = self.createdClass
        classSessionVC.activityStatus = .Edit
        classSessionVC.previousViewController = self
        self.navigationController!.pushViewController(classSessionVC, animated: true)
    }
    
    func configureNavigationBar() {
        switch self.activityStatus {
        case .Edit:
            self.navigationItem.rightBarButtonItem = self.doneButton
            self.navigationItem.title = self.createdClass == nil ? "Creating new class" : self.navigationItem.title
        case .View:
            self.navigationItem.rightBarButtonItem = self.editButton
            self.navigationItem.title = self.createdClass != nil ? "\(self.createdClass!.title)" : ""
        case .Select(_):
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func configureTextFields() {
        switch self.activityStatus {
        case .Edit:
            self.titleTextField.isUserInteractionEnabled = true
            self.descriptionTextField.isUserInteractionEnabled = true
            self.durationTextField.isUserInteractionEnabled = true
            self.capacityTextField.isUserInteractionEnabled = true
            self.numOfLPSTextField.isUserInteractionEnabled = true
        default:
            self.titleTextField.isUserInteractionEnabled = false
            self.descriptionTextField.isUserInteractionEnabled = false
            self.durationTextField.isUserInteractionEnabled = false
            self.capacityTextField.isUserInteractionEnabled = false
            self.numOfLPSTextField.isUserInteractionEnabled = false
        }
    }
    
    func initializeTextFields() {
        guard let createdClass = self.createdClass else {
            return
        }
        self.titleTextField.text = createdClass.title
        self.descriptionTextField.text = createdClass.description
        self.durationTextField.text = "\(createdClass.duration)"
        if let capacity = createdClass.capacity {
            self.capacityTextField.text = "\(capacity)"
        } else {
            self.capacityTextField.text = ""
        }
        if let numOfLPS = createdClass.numOfLessonsPerSession {
            self.numOfLPSTextField.text = "\(numOfLPS)"
        } else {
            self.numOfLPSTextField.text = ""
        }
    }
    
    @objc func doneEditing(_ sender: UIBarButtonItem) {
        self.activityStatus = .View
        self.configureNavigationBar()
        self.configureTextFields()
        if self.createdClass == nil {
            self.saveNewClass()
        } else {
            self.patchExistingClass()
        }
    }
    
    @objc func beginEditing(_ sender: UIBarButtonItem) {
        self.activityStatus = .Edit
        self.configureNavigationBar()
        self.configureTextFields()
    }
    
    func saveNewClass() {
        if self.createdClass != nil {
            print("class is being modified not created!")
            return
        }
        guard let title = self.titleTextField.text, let description = self.descriptionTextField.text, let durationText = self.durationTextField.text, let duration = Int(durationText) else {
            print("Invalid title, description or duration!")
            return
        }
        var classToCreate = Class(title: title, description: description, creatorID: self.user!.id!, duration: duration)
        if let capacityText = self.capacityTextField.text, let capacity = Int(capacityText) {
            classToCreate.capacity = capacity
        }
        if let numOfLPSText = self.numOfLPSTextField.text, let numOfLPS = Int(numOfLPSText) {
            classToCreate.numOfLessonsPerSession = numOfLPS
        }
        BackendDataService.shared.save(ClassBackendResource(of: classToCreate)) {
            guard let newClass = $0?.modelObj else {
                print("failed to create class with title \(classToCreate.title)")
                return
            }
            self.createdClass = newClass
            if self.user.createdClasses != nil {
                self.user.createdClasses?.append(newClass)
            } else {
                self.user.createdClasses = [newClass]
            }
            print("Successfully created new class by user \(self.user!.username)")
            DispatchQueue.main.async {
                self.configureNavigationBar()
            }
        }
    }
    
    func patchExistingClass() {
        guard var oldClass = self.createdClass else {
            print("the class to patch is nil!")
            return
        }
        guard let title = self.titleTextField.text, let description = self.descriptionTextField.text, let durationText = self.durationTextField.text, let duration = Int(durationText) else {
            print("Invalid title, description or duration!")
            return
        }
        var patchDataDict: [String: Any] = ["title": title, "description": description, "duration": duration]
        if let capacityText = self.capacityTextField.text, let capacity = Int(capacityText) {
            patchDataDict["capacity"] = capacity
        }
        if let numOfLPSText = self.numOfLPSTextField.text, let numOfLPS = Int(numOfLPSText) {
            patchDataDict["num_of_lessons_per_session"] = numOfLPS
        }
        BackendDataService.shared.patchWithID(oldClass.id!, type: ClassBackendResource.self, data: patchDataDict) {
            guard let newClass = $0?.modelObj else {
                print("failed to patch class \(oldClass.id!)")
                return
            }
            self.createdClass = newClass
            print("Successfully patched class \(oldClass.id!)")
            DispatchQueue.main.async {
                self.configureNavigationBar()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.createdClass?.sessions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ClassSessionTableViewCell.self)", for: indexPath) as! ClassSessionTableViewCell
        cell.classTitleLabelHeightConstraint.constant = 0
        guard let session = self.createdClass?.sessions?[indexPath.row], let schedule = session.schedule, let firstTimeslot = schedule.baseTimeslots?.first else {
            return cell
        }
        cell.startTimeLabel.text = self.dateFormatter.string(from: firstTimeslot.startAt)
        cell.endTimeLabel.text = schedule.repeatEndAt != nil ? self.dateFormatter.string(from: schedule.repeatEndAt!) : ""
        cell.repeatOptionLabel.text = String(schedule.repeatOption.rawValue.split(separator: ".")[1])
        cell.durationLabel.text = "\(firstTimeslot.duration)"
        cell.numOfEnrollmentsLabel.text = "\(session.enrollments!.count)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Sessions"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let session  = self.createdClass?.sessions?[indexPath.row] else {
            return
        }
        switch self.activityStatus {
        case .Select(var person):
            var enrollment = Enrollment(classSessionID: session.id!, enrolledPersonID: person.id!, initiatorID: self.user.id!, terminated: false)
            BackendDataService.shared.save(EnrollmentBackendResource(of: enrollment)) {
                guard let savedEnrollment = $0?.modelObj else {
                    return
                }
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        default:
            return
        }
    }
    
}
