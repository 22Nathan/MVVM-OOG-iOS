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
    var imageScrollView = UIScrollView()
    var pageControl = UIPageControl()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubViews(subViews: [userAvatar,usernameLabel,imageScrollView,pageControl])
        layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        userAvatar.left(4).top(5).width(46).height(46)
        userAvatar.layer.masksToBounds = true
        userAvatar.clipsToBounds = true
        userAvatar.layer.cornerRadius = 23.0
        userAvatar.contentMode = UIViewContentMode.scaleAspectFit
        
        usernameLabel.top(5).after(userAvatar,4).height(21).width(120)
        
        imageScrollView.below(userAvatar, 10)
        imageScrollView.left(0).right(0).height(UIScreen.main.bounds.height)
        
        imageScrollView.addSubview(pageControl)
        pageControl.centerX()
        pageControl.bottom(8)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        pageControl.hidesForSinglePage = true
    }
}
