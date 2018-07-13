//
//  ClassSessionViewController.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/12/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import UIKit

class ClassSessionViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    enum ActivityStatus {
        case Edit
        case View
        case Select(person: PersonClassifiable)
    }
    
    @IBOutlet weak var endAtDatePickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var repeatOptionPickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var startTImeDatePickerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var endAtDatePicker: UIDatePicker!
    @IBOutlet weak var repeatOptionPicker: UIPickerView!
    @IBOutlet weak var startTimeDatePicker: UIDatePicker!
    @IBOutlet weak var endAtTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var repeatOptionTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    var doneButton: UIBarButtonItem!
    var editButton: UIBarButtonItem!
    weak var previousViewController: UIViewController?
    
    var user: User!
    var parentClass: Class!
    var classSession: ClassSession?
    var startTime: Date?
    var repeatOption: RepeatOption?
    var endAt: Date?
    var duration: Int?
    var activityStatus: ActivityStatus = .View
    
    var endAtDatePickerHeightConstraintConstant: CGFloat!
    var startTimeDatePickerHeightConstraintConstant: CGFloat!
    var repeatOptionPickerHeightConstraintConstant: CGFloat!
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, h:mm a"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneEditing(_:)))
        self.editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(beginEditing(_:)))
        self.configureNavigationBar()
        self.initializeTextFields()
        self.configureTextFields()
        self.initializePickers()
        
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        if let profileVC = self.previousViewController as? ProfileViewController {
//            profileVC.user = self.user
//        }
//    }
    
    func initializePickers() {
        self.startTimeDatePickerHeightConstraintConstant = self.startTImeDatePickerHeightConstraint.constant
        self.endAtDatePickerHeightConstraintConstant = self.endAtDatePickerHeightConstraint.constant
        self.repeatOptionPickerHeightConstraintConstant = self.repeatOptionPickerHeightConstraint.constant
        self.startTImeDatePickerHeightConstraint.constant = 0
        self.endAtDatePickerHeightConstraint.constant = 0
        self.repeatOptionPickerHeightConstraint.constant = 0
        self.repeatOptionPicker.delegate = self
        self.repeatOptionPicker.dataSource = self
        
    }
    
    func configureNavigationBar() {
        switch self.activityStatus {
        case .Edit:
            self.navigationItem.rightBarButtonItem = self.doneButton
            self.navigationItem.title = self.classSession == nil ? "Creating new session for \(self.parentClass.title)" : self.navigationItem.title
        case .View:
            self.navigationItem.rightBarButtonItem = self.editButton
            self.navigationItem.title =  ""
        case .Select(_):
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func configureTextFields() {
        switch self.activityStatus {
        case .Edit:
            self.startTimeTextField.isUserInteractionEnabled = true
            self.repeatOptionTextField.isUserInteractionEnabled = true
            self.endAtTextField.isUserInteractionEnabled = true
        default:
            self.startTimeTextField.isUserInteractionEnabled = false
            self.repeatOptionTextField.isUserInteractionEnabled = false
            self.endAtTextField.isUserInteractionEnabled = false
        }
    }
    
    func initializeTextFields() {
        self.startTimeTextField.delegate = self
        self.endAtTextField.delegate = self
        self.repeatOptionTextField.delegate = self
        guard let session = self.classSession, let schedule = session.schedule, let baseTimeslots = schedule.baseTimeslots, let firstTimeslot = baseTimeslots.first else {
            return
        }
        self.startTimeTextField.text = dateFormatter.string(from: firstTimeslot.startAt)
        self.repeatOptionTextField.text = schedule.repeatOption.rawValue
        if let endAt = schedule.repeatEndAt {
            self.endAtTextField.text = dateFormatter.string(from: endAt)
        } else {
            self.endAtTextField.text = ""
        }
        self.durationTextField.placeholder = "\(self.parentClass.duration)"
    }
    
    @objc func doneEditing(_ sender: UIBarButtonItem) {
        self.activityStatus = .View
        self.configureNavigationBar()
        self.configureTextFields()
        if self.classSession == nil {
            self.saveNewClassSession()
        } else {
//            self.patchExistingClassSession()
        }
    }
    
    @objc func beginEditing(_ sender: UIBarButtonItem) {
        self.activityStatus = .Edit
        self.configureNavigationBar()
        self.configureTextFields()
    }
    
    func saveNewClassSession() {
        if self.classSession != nil {
            print("classSession is being modified not created!")
            return
        }
        guard let start = self.startTime,  let repOption = self.repeatOption, let endAt = self.endAt else {
            print("Invalid start, repeat or end time!")
            return
        }
        let timeslot = Timeslot(startAt: start, duration: self.duration ?? self.parentClass.duration)
        var schedule = Schedule(repeatOption: repOption)
        schedule.repeatEndAt = endAt
        schedule.baseTimeslots = [timeslot]
        BackendDataService.shared.save(ScheduleBackendResource(of: schedule)) {
            guard let newSchedule = $0?.modelObj else {
                print("failed to create schedule")
                return
            }
            let  classSession =  ClassSession(classID: self.parentClass.id!, creatorID: self.user.id!, scheduleID: newSchedule.id!)
            BackendDataService.shared.save(ClassSessionBackendResource(of: classSession)) {
                guard var newClassSession = $0?.modelObj else {
                    print("failed to create class session")
                    return
                }
                newClassSession.schedule = newSchedule
                self.classSession = newClassSession
                if self.parentClass.sessions != nil {
                    self.parentClass.sessions?.append(newClassSession)
                } else {
                    self.parentClass.sessions = [newClassSession]
                }
                print("Successfully created new class session by user \(self.user!.username)")
                DispatchQueue.main.async {
                    self.configureNavigationBar()
                }
            }
        }
    }
    
    func hidePickers() {
        self.startTImeDatePickerHeightConstraint.constant = 0
        self.endAtDatePickerHeightConstraint.constant = 0
        self.repeatOptionPickerHeightConstraint.constant = 0
    }
    
    func showPickers() {
        self.startTImeDatePickerHeightConstraint.constant = self.startTimeDatePickerHeightConstraintConstant
        self.endAtDatePickerHeightConstraint.constant = self.endAtDatePickerHeightConstraintConstant
        self.repeatOptionPickerHeightConstraint.constant = self.repeatOptionPickerHeightConstraintConstant
    }
    
    @IBAction func onViewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        self.hidePickers()
    }
    
    @IBAction func onStartTimePicked(_ sender: UIDatePicker) {
        self.startTimeTextField.text = self.dateFormatter.string(from: sender.date)
        self.startTime = sender.date
    }
    
    @IBAction func onEndTimePicked(_ sender: UIDatePicker) {
        self.endAtTextField.text = self.dateFormatter.string(from: sender.date)
        self.endAt = sender.date
    }
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return RepeatOption.allValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(RepeatOption.allValues[row].rawValue.split(separator: ".")[1])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.repeatOption = RepeatOption.allValues[row]
        self.repeatOptionTextField.text = String(RepeatOption.allValues[row].rawValue.split(separator: ".")[1])
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField === self.startTimeTextField {
            self.startTImeDatePickerHeightConstraint.constant = self.startTimeDatePickerHeightConstraintConstant
            return false
        }
        if textField === self.repeatOptionTextField {
            self.repeatOptionPickerHeightConstraint.constant = self.repeatOptionPickerHeightConstraintConstant
            return false
        }
        if textField === self.endAtTextField {
            self.endAtDatePickerHeightConstraint.constant = self.endAtDatePickerHeightConstraintConstant
            return false
        }
        return true
    }
//    func patchExistingClassSession() {
//        guard var oldClass = self.createdClass else {
//            print("the class to patch is nil!")
//            return
//        }
//        guard let title = self.titleTextField.text, let description = self.descriptionTextField.text, let durationText = self.durationTextField.text, let duration = Int(durationText) else {
//            print("Invalid title, description or duration!")
//            return
//        }
//        var patchDataDict: [String: Any] = ["title": title, "description": description, "duration": duration]
//        if let capacityText = self.capacityTextField.text, let capacity = Int(capacityText) {
//            patchDataDict["capacity"] = capacity
//        }
//        if let numOfLPSText = self.numOfLPSTextField.text, let numOfLPS = Int(numOfLPSText) {
//            patchDataDict["num_of_lessons_per_session"] = numOfLPS
//        }
//        BackendDataService.shared.patchWithID(oldClass.id!, type: ClassBackendResource.self, data: patchDataDict) {
//            guard let newClass = $0?.modelObj else {
//                print("failed to patch class \(oldClass.id!)")
//                return
//            }
//            self.createdClass = newClass
//            print("Successfully patched class \(oldClass.id!)")
//            DispatchQueue.main.async {
//                self.configureNavigationBar()
//            }
//        }
//    }
    
}
