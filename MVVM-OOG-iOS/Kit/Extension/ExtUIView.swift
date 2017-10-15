//
//  ExtUIView.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 13/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func addSubViews(subViews : [UIView]){
        for subView in subViews{
            self.addSubview(subView)
        }
    }
}
