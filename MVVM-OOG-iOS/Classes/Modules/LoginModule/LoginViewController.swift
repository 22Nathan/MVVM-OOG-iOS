//
//  LoginViewController.swift
//  MVVM-OOG-iOS
//
//  Created by Nathan on 09/10/2017.
//  Copyright © 2017 Nathan. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import SVProgressHUD

class LoginViewController: UIViewController {
    
    var teleTextField = UITextField()
    var passwordTextField = UITextField()
    var loginButton = UIButton()
    
    var viewModel = LoginViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubViews(subViews: [teleTextField,passwordTextField,loginButton])
        initialUI()
        
        loginButton.addTarget(self, action: #selector(login), for: .touchDown)
        viewModel.loginInfo.subscribe(
            onNext:{ text in
                let mainTabBarVC = MainTarBarViewController()
                self.present(mainTabBarVC, animated: true, completion: nil)
            },
            onError:{ error in
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            },
            onDisposed:{
                print("Finish Login Request.")
            }
        ).addDisposableTo(bag)
    }
    
    private func initialUI(){
        teleTextField.placeholder = "请输入手机号"
        teleTextField.text = "15051857918"
        teleTextField.borderStyle = .roundedRect
        teleTextField.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(120, 75, view.frame.size.height - 120 - 30, 75))
        }
        
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.text = "123456"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.snp.makeConstraints { (make) in
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(170, 75, view.frame.size.height - 170 - 30, 75))
        }

        loginButton.setTitle("Login", for: .normal)
        loginButton.isEnabled = true
        loginButton.setTitleColor(UIColor.black, for: .normal)
        loginButton.frame.size = CGSize(width: 100, height: 30)
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view).offset(-100)
        }
    }
    
    func login(){
        let data = LoginModel(teleTextField.text!,passwordTextField.text!)
        viewModel.model = data
        viewModel.requestLogin()
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
