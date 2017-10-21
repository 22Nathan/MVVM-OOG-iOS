//
//  MovementsTableView.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 13/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import Foundation
import UIKit

extension MovementsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}




