//
//  ClassTableViewCell.swift
//  ClassDoor
//
//  Created by zhenduo zhu on 7/12/18.
//  Copyright © 2018 zhenduo zhu. All rights reserved.
//

import Foundation
import UIKit

class ClassTableViewCell: UITableViewCell {
    var titleLabel: UILabel!
    var descriptionLabel: UILabel!
    var durationLabel: UILabel!
    var createdByLabel: UILabel!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    func setup() {
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.durationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.createdByLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.createdByLabel)
        self.contentView.addSubview(self.durationLabel)
        self.setupTitleLabel()
        self.setupDescriptionLabel()
        self.setupCreatedByLabel()
        self.setupDurationLabel()
    }
    func setupTitleLabel() {
        self.titleLabel.font = UIFont.systemFont(ofSize: 15)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.numberOfLines = 0
        self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        self.titleLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor).isActive = true
    }
    func setupDescriptionLabel() {
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.numberOfLines = 0
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8).isActive = true
    }
    func setupCreatedByLabel() {
        self.createdByLabel.font = UIFont.systemFont(ofSize: 15)
        self.createdByLabel.translatesAutoresizingMaskIntoConstraints = false
        self.createdByLabel.numberOfLines = 0
        self.createdByLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 8).isActive = true
        self.createdByLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        self.createdByLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor).isActive = true
    }
    func setupDurationLabel() {
        self.durationLabel.font = UIFont.systemFont(ofSize: 15)
        self.durationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.durationLabel.numberOfLines = 0
        self.durationLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 8).isActive = true
        self.durationLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        self.durationLabel.leadingAnchor.constraint(equalTo: self.createdByLabel.trailingAnchor).isActive = true
        self.durationLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        
    }
}
