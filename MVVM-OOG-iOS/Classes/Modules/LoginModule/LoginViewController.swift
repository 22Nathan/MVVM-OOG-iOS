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
import RxCocoa
import SVProgressHUD

class LoginViewController: UIViewController {
    
    var telTextField = UITextField()
    var passwordTextField = UITextField()
    var loginButton = UIButton()
    
    var viewModel = LoginViewModel()
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubViews(subViews: [telTextField,passwordTextField,loginButton])
        layoutSubViews()
        
        //Subscribe Valid telNumber
        let telObservable = self.telTextField.rx.text.asObservable().map { (input: String?) -> Bool in
            return ValidInputHelper.isValidTel(tel: input!)
            }
        
        telObservable.map { (valid: Bool) -> UIColor in
            return valid ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }.subscribe(
                onNext: {
                    self.telTextField.layer.borderColor = $0.cgColor
                },
                onDisposed:{
                    print("telObserble disposed")
                }
            ).addDisposableTo(bag)
        
        //Subscribe Valid password
        let passwordObservale = self.passwordTextField.rx.text.asObservable().map { (input: String?) -> Bool in
            return ValidInputHelper.isValidPassword(password: input!)
            }
        
        passwordObservale.map { (valid: Bool) -> UIColor in
            return valid ? #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }.subscribe(
                onNext: {
                    self.passwordTextField.layer.borderColor = $0.cgColor
                },
                onDisposed:{
                    print("telObserble disposed")
                }
            ).addDisposableTo(bag)
        
        //Subscribe enable login Button
        Observable.combineLatest(telObservable, passwordObservale) {
            (validTel: Bool, valdPassword: Bool) -> [Bool] in
                return [validTel,valdPassword]
            }.map { (input: [Bool]) -> Bool in
                return input.reduce(true, {$0 && $1})
            }
            .bind(to: loginButton.rx.isEnabled)
            .addDisposableTo(bag)
        
        loginButton.addTarget(self, action: #selector(login), for: .touchDown)
        
        /*
         这样订阅，而alamofire直接create一个observable,返回的是LoginModel对象。
         但我觉得这里的情况给一个提示信息就可以了，因为view要做的只是转场操作，缓存应该放在viewmodel里
         loginButton.rx.tap
         .map{
         
         }
         */
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
    
    private func layoutSubViews(){
        telTextField.placeholder = "请输入手机号"
        telTextField.text = "15051857918"
        telTextField.borderStyle = .roundedRect
        telTextField.layer.borderWidth = 1
        telTextField.top(0.2 * UIScreen.main.bounds.height).centerX().left(75).right(75)
        
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.text = "123456"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderWidth = 1
        passwordTextField.below(telTextField,40).centerX().left(75).right(75)

        loginButton.setTitle("Login", for: .normal)
        loginButton.isEnabled = true
        loginButton.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        loginButton.setTitleColor(#colorLiteral(red: 0.7574584487, green: 0.7574584487, blue: 0.7574584487, alpha: 1), for: .disabled)
        loginButton.frame.size = CGSize(width: 100, height: 30)
        loginButton.below(passwordTextField,30).centerX().left(120).right(120)
    }
    
    func login(){
        let data = LoginModel(telTextField.text!,passwordTextField.text!)
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
