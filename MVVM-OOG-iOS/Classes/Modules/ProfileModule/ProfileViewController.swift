//
//  ProfileViewController.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 12/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController {

    var loginButton = UIButton()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(loginButton)
        layoutSubViews()
        
        loginButton.rx.tap.asObservable().subscribe(
            onNext: {
                let alert = UIAlertController(title: "提示", message: "您确定要退出登录吗", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(cancelAction)
                alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { action in
                    OOGUserDefault.ifLogin = false
                    OOGUserDefault.uuid = ""
                    let loginVC = LoginViewController()
                    self.present(loginVC, animated: true, completion: nil)
                }))
                self.present(alert, animated: true)
            },
            onDisposed:{
                print("logout disposed")
            }
            ).addDisposableTo(bag)
    }
    
    private func layoutSubViews(){
        loginButton.centerX().centerY().height(40).width(130)
        loginButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        if OOGUserDefault.ifLogin == true{
            loginButton.setTitle("退出登录", for: .normal)
        }
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
