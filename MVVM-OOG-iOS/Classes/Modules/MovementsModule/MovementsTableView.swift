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
    
}

extension MovementsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return testArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movement", for: indexPath) as! MovementTableViewCell
        cell.textLabel?.text = testArray[indexPath.section][indexPath.row]
        //        cell.delegate = self
        return cell
    }

}

