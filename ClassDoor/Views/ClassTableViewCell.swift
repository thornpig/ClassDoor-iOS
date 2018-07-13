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
    var titleLabel: UILabel
    var descriptionLabel: UILabel
    var durationLabel: UILabel
    var createdByLabel: UILabel
    required init?(coder aDecoder: NSCoder) {
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.durationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.createdByLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        super.init(coder: aDecoder)
        self.setup()
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.durationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.createdByLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    func setup() {
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
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 8))
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: -8))
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1, constant: 0))
    }
    func setupDescriptionLabel() {
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.numberOfLines = 0
        self.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 8))
        self.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailing, multiplier: 1, constant: -8))
        self.addConstraint(NSLayoutConstraint(item: self.descriptionLabel, attribute: .top, relatedBy: .equal, toItem: self.titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
    }
    func setupCreatedByLabel() {
        self.createdByLabel.font = UIFont.systemFont(ofSize: 15)
        self.createdByLabel.translatesAutoresizingMaskIntoConstraints = false
        self.createdByLabel.numberOfLines = 1
        self.addConstraint(NSLayoutConstraint(item: self.createdByLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leading, multiplier: 1, constant: 8))
        self.addConstraint(NSLayoutConstraint(item: self.createdByLabel, attribute: .top, relatedBy: .equal, toItem: self.descriptionLabel, attribute: .bottom, multiplier: 1, constant: 8))
        self.addConstraint(NSLayoutConstraint(item: self.createdByLabel, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.createdByLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 180))
    }
    func setupDurationLabel() {
        self.durationLabel.font = UIFont.systemFont(ofSize: 15)
        self.durationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.durationLabel.numberOfLines = 1
        self.addConstraint(NSLayoutConstraint(item: self.durationLabel, attribute: .leading, relatedBy: .equal, toItem: self.createdByLabel, attribute: .trailing, multiplier: 1, constant: 20))
        //                self.addConstraint(NSLayoutConstraint(item: self.durationLabel, attribute: .centerY, relatedBy: .equal, toItem: self.createdByLabel, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.durationLabel, attribute: .top, relatedBy: .equal, toItem: self.createdByLabel, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.durationLabel, attribute: .bottom, relatedBy: .equal, toItem: self.createdByLabel, attribute: .bottom, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.durationLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 100))
    }
}
