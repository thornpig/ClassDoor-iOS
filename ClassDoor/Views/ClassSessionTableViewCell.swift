//
//  ClassSessionTableViewCell.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/12/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import UIKit

class ClassSessionTableViewCell: UITableViewCell {

    @IBOutlet weak var classTitleLabelEqualHeightsConstraint: NSLayoutConstraint!
    @IBOutlet weak var classTitleLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var numOfEnrollmentsLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var repeatOptionLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var classTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.classTitleLabel.text = ""
        self.startTimeLabel.text = ""
        self.durationLabel.text = ""
        self.repeatOptionLabel.text = ""
        self.endTimeLabel.text  = ""
        self.numOfEnrollmentsLabel.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
