//
//  MovementsViewController.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 11/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class MovementsViewController: UIViewController,UIScrollViewDelegate {
    
    var movementTableView = UITableView()
    var scrollView = UIScrollView()
    var segmentedControl = UISegmentedControl()
    
    //MARK: - Model
    var testArray : [[String]] = [["123","232","3123","dssa"]]
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubViews(subViews: [segmentedControl,scrollView])
        initialUI()
        movementTableView.reloadData()
    }
    
    private func initialUI(){
        //initial segmentedControl
        segmentedControl.top(0).left(0).right(0)
        segmentedControl.tintColor = UIColor.clear
        
        segmentedControl.insertSegment(withTitle: "动态", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "热门", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes(unselectedTextAttributes as [NSObject : AnyObject], for: UIControlState.normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes as [NSObject : AnyObject], for: UIControlState.selected)
        
        //initial scrollView
        scrollView.frame = CGRect(x: 0, y: segmentedControl.frame.height, width: view.frame.width, height: view.frame.height - segmentedControl.frame.height)
        scrollView.below(segmentedControl).width(view.frame.width).height(view.frame.height - segmentedControl.frame.height)
        scrollView.delegate = self
//        scrollView.isPagingEnabled = true
        let scrollViewFrame = scrollView.bounds
        scrollView.contentSize = CGSize(width: scrollViewFrame.size.width * CGFloat(segmentedControl.numberOfSegments), height: scrollViewFrame.size.height)
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        //initial tableView
        scrollView.addSubview(movementTableView)
        movementTableView.closelyInside(scrollView)
        movementTableView.delegate = self
        movementTableView.dataSource = self
        movementTableView.register(MovementTableViewCell.self, forCellReuseIdentifier: "Movement")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
