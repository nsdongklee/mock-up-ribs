//
//  LoginViewController.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/14.
//

import RIBs
import RxSwift
import UIKit

protocol LoginPresentableListener: AnyObject {
    func didTapBackButton()
    func checkInput(id: String?)
    func checkInput(pw: String?)
    func didTapLogin()
}

final class LoginViewController: UIViewController, LoginPresentable, LoginViewControllable {
    
    var viewModel: LoginViewModel = LoginViewModel()
    
    private let disposeBag = DisposeBag()

    weak var listener: LoginPresentableListener?
    
    private let loginableView = LoginableView()
    
    private lazy var loginButton: UIButton = {
        let b = UIButton()
        b.setTitle("로그인", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        b.setTitleColor(.white, for: .normal)
        b.setBackgroundColor(.systemBlue, for: .normal)
        b.setBackgroundColor(.systemBlue.withAlphaComponent(0.6), for: .highlighted)
        b.setTitleColor(.white, for: .disabled)
        b.setBackgroundColor(.systemGray4, for: .disabled)
        b.roundCorners()
        b.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        return b
    }()
    
    init(dismissButtonType: DismissButtonType) {
        super.init(nibName: nil, bundle: nil)
        setupViews()
        setupNavigationItem(with: dismissButtonType, target: self, action: #selector(didTapBackButton))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupViews() {
        title = "로그인"
        view.backgroundColor = .white
        
        view.addSubview(loginableView)
        loginableView.addArrangedSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(58)
        }
        
        loginableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        bind()
    }
    
    private func bind() {
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(didTapBackgroundView)
            )
        )
        
        loginableView.delegate = self
        
        viewModel.isValidID
            .skip(1)
            .bind { [weak self] (input, isValid) in
                self?.loginableView.isValidID(isValid)
            }
            .disposed(by: disposeBag)
        
        viewModel.isValidPW
            .skip(1)
            .bind { [weak self] (input, isValid) in
                self?.loginableView.isValidPW(isValid)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.isValidID, viewModel.isValidPW)
            .map { $0.1 && $1.1 }
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    @objc private func didTapBackgroundView() {
        loginableView.resignAll()
    }
    
    @objc private func didTapBackButton(_ sender: UIButton) {
        listener?.didTapBackButton()
    }
    
    @objc private func didTapLoginButton(_ sender: UIButton) {
        listener?.didTapLogin()
    }
}


//MARK: - 로그인 뷰의 이벤트 델리게이트
extension LoginViewController: LoginableViewDelegate {
    
    func checkInput(id: String?) {
        listener?.checkInput(id: id)
    }
    
    func checkInput(pw: String?) {
        listener?.checkInput(pw: pw)
    }
}
