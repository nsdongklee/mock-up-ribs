//
//  LoginableView.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/14.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoginableViewDelegate: AnyObject {
    func checkInput(id: String?)
    func checkInput(pw: String?)
}

class LoginableView: UIStackView {
    
    public weak var delegate: LoginableViewDelegate?
    
    private let disposeBag = DisposeBag()
    
    private let idTitle: UILabel = {
        let l = UILabel()
        l.backgroundColor = .clear
        l.text = "아이디"
        l.textAlignment = .left
        l.font = .systemFont(ofSize: 16, weight: .medium)
        return l
    }()
    
    private lazy var idTextField: MockTextField = {
        let t = MockTextField()
        t.backgroundColor = .white
        t.setupValidateCheck()
        t.rightViewMode = .always
        t.placeholder = "아이디를 입력하세요."
        return t
    }()
    
    private let pwTitle: UILabel = {
        let l = UILabel()
        l.backgroundColor = .clear
        l.text = "비밀번호"
        l.textAlignment = .left
        l.font = .systemFont(ofSize: 16, weight: .medium)
        return l
    }()
    
    private lazy var pwTextField: MockTextField = {
        let t = MockTextField()
        t.backgroundColor = .white
        t.setupValidateCheck()
        t.rightViewMode = .always
        t.placeholder = "비밀번호를 입력하세요."
        t.isSecureTextEntry = true
        return t
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 3
        backgroundColor = .white
        layoutMargins = .init(top: 32, left: 16, bottom: 8, right: 16)
        isLayoutMarginsRelativeArrangement = true
        
        addArrangedSubview(idTitle)
        addArrangedSubview(idTextField)
        addArrangedSubview(pwTitle)
        addArrangedSubview(pwTextField)
        
        
        idTextField.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        pwTextField.snp.makeConstraints { make in
            make.height.equalTo(52)
        }
        
        setCustomSpacing(24, after: idTextField)
        setCustomSpacing(52, after: pwTextField)
        
        bind()
    }
    
    private func bind() {
        idTextField.rx.text.orEmpty
            .subscribe(onNext: { [weak self] id in
                self?.delegate?.checkInput(id: id)
            })
            .disposed(by: disposeBag)
        idTextField.rx.controlEvent(.editingDidBegin)
            .bind { [weak self] in
                self?.idTextField.hideValidateWithActive(true, rightViewAlways: false)
            }
            .disposed(by: disposeBag)
        idTextField.rx.controlEvent(.editingDidEnd)
            .bind { [weak self] in
                let id = self?.idTextField.text ?? ""
                if Jarvis.shared.validate(id: id) {
                    self?.idTextField.hideValidateWithActive(false, rightViewAlways: true)
                }
            }.disposed(by: disposeBag)
        
        pwTextField.rx.text.orEmpty
            .subscribe(onNext: { [weak self] pw in
                self?.delegate?.checkInput(pw: pw)
            })
            .disposed(by: disposeBag)
        pwTextField.rx.controlEvent(.editingDidBegin)
            .bind { [weak self] in
                self?.pwTextField.hideValidateWithActive(true, rightViewAlways: false)
            }
            .disposed(by: disposeBag)
        pwTextField.rx.controlEvent(.editingDidEnd)
            .bind { [weak self] in
                self?.pwTextField.withActive(false)
            }.disposed(by: disposeBag)
    }
    
    public func isValidID(_ isValid: Bool) {
        if isValid {
            idTextField.showValidateCheck()
            idTextField.hideValidateWithActive(true, rightViewAlways: true)
        } else {
            idTextField.showValidate(with: "1 에서 10 사이의 유저 아이디를 입력해주세요.")
        }
    }
                                     
    public func isValidPW(_ isValid: Bool) {
        if isValid {
            pwTextField.showValidateCheck()
            pwTextField.hideValidateWithActive(true, rightViewAlways: true)
        } else {
            pwTextField.showValidate(with: "5자리 이상 입력해주세요.")
        }
    }
    
    public func resignAll() {
        idTextField.resignFirstResponder()
        pwTextField.resignFirstResponder()
    }
}
