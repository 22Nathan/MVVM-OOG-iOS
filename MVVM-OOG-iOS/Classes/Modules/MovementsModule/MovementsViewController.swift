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
import RxDataSources
import SVProgressHUD
import SDWebImage
import DGElasticPullToRefresh

class MovementsViewController: UIViewController {
    
    var movementTableView = UITableView()
    var scrollView = UIScrollView()
    var segmentedControl = UISegmentedControl()
    let loadingView = DGElasticPullToRefreshLoadingViewCircle()
    
    var viewModel = MovesmentViewModel()
    let bag = DisposeBag()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionTableModel>()
    typealias SectionTableModel = SectionModel<String,Movement>
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubViews(subViews: [segmentedControl,scrollView])
        layoutSubViews()
        
        movementTableView.delegate = self
        movementTableView.register(MovementTableViewCell.self, forCellReuseIdentifier: "Movement")
        movementTableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            self?.viewModel.prepareData(completionHandler: { () -> Void in
                self?.movementTableView.dg_stopLoading()
            },isRefresh: true)
            }, loadingView: loadingView)
        setConfigureCell()
        
        viewModel.MovementList.subscribe(
            onNext:{ movementArray in
                self.movementTableView.dataSource = nil
                Observable.just(self.createSectionModel(movementArray))
                          .bind(to: self.movementTableView.rx.items(dataSource: self.dataSource))
                          .addDisposableTo(self.bag)
            },
            onError:{ error in
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            },
            onDisposed:{
                print("Finish Login Request.")
            }).addDisposableTo(bag)

        viewModel.prepareData(completionHandler: { () -> Void in
            self.movementTableView.dg_stopLoading()
        })
    }
    
    private func setConfigureCell(){
        dataSource.configureCell = {(_,tv,indexPath,item) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Movement", for: indexPath) as! MovementTableViewCell
            cell.usernameLabel.text = item.owner_userName
            cell.userAvatar.sd_setImage(with: URL(string: item.owner_avatar) , placeholderImage: #imageLiteral(resourceName: "defaultImage"))
            cell.testImage.sd_setImage(with: URL(string: item.imageUrls) , placeholderImage: #imageLiteral(resourceName: "defaultImage"))
            return cell
        }
    }
    
    private func createSectionModel(_ movementList: [Movement]) -> [SectionTableModel]{
        return [SectionTableModel(model: "", items: movementList)]
    }
    
    private func layoutSubViews(){
        //initial segmentedControl
        segmentedControl.top(25).left(0).right(0)
        segmentedControl.tintColor = UIColor.clear
        
        segmentedControl.insertSegment(withTitle: "动态", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "热门", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes(unselectedTextAttributes as [NSObject : AnyObject], for: UIControlState.normal)
        segmentedControl.setTitleTextAttributes(selectedTextAttributes as [NSObject : AnyObject], for: UIControlState.selected)
        
        //initial scrollView
        scrollView.frame = CGRect(x: 0, y: segmentedControl.frame.height, width: view.frame.width, height: view.frame.height - segmentedControl.frame.height - 100)
        scrollView.below(segmentedControl).width(view.frame.width).height(view.frame.height - segmentedControl.frame.height - 100)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        let scrollViewFrame = scrollView.bounds
        scrollView.contentSize = CGSize(width: scrollViewFrame.size.width * CGFloat(segmentedControl.numberOfSegments), height: scrollViewFrame.size.height)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        
        //initial tableView
        movementTableView.frame = scrollViewFrame
        movementTableView.allowsSelection = false
        scrollView.addSubview(movementTableView)
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

extension MovementsViewController: UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let segments = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        segmentedControl.selectedSegmentIndex = segments
        segmentChanged(segmentedControl)
    }
    
    func segmentChanged(_ sender : UISegmentedControl){
        let index = sender.selectedSegmentIndex
        var frame = scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(index)
        frame.origin.y = 0
        scrollView.scrollRectToVisible(frame, animated: true)
    }
}
