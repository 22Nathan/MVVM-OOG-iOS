//
//  MovementTableViewCell.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 13/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import SnapKit

class MovementTableViewCell: UITableViewCell {
    
    var userAvatar = UIImageView()
    var usernameLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubViews(subViews: [userAvatar,usernameLabel])
        layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        userAvatar.left(4).top(5).width(46).height(46)
        usernameLabel.top(5).after(userAvatar,4).height(21).width(120)
    }
}
