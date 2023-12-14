//
//  LoginableEmptyView.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/14.
//

import UIKit

protocol LoginableEmptyViewDelegate: AnyObject {
    func didTapLogin()
}

class LoginableEmptyView: UIView {
    
    public weak var delegate: LoginableEmptyViewDelegate?
    
    private let loginableLabel: UILabel = {
        let l = UILabel()
        l.text = "로그인하고\n서비스를 이용해보세요."
        l.textColor = .darkGray
        l.font = .systemFont(ofSize: 23, weight: .semibold)
        l.textAlignment = .center
        l.numberOfLines = 0
        l.lineBreakMode = .byCharWrapping
        return l
    }()
    
    private lazy var loginableButton: UIButton = {
        let b = UIButton()
        b.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        b.setTitle("로그인", for: .normal)
        b.setTitleColor(.systemBlue, for: .normal)
        b.backgroundColor = .white
        b.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        b.layer.borderWidth = 1.0
        b.layer.cornerRadius = 8.0
        b.layer.cornerCurve = .continuous
        b.layer.borderColor = UIColor.systemBlue.cgColor
        return b
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        backgroundColor = .white
        
        addSubview(loginableLabel)
        addSubview(loginableButton)
        
        loginableLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(-6)
        }
        
        loginableButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.snp.centerY).offset(6)
            make.width.equalTo(100)
            make.height.equalTo(48)
        }
    }
    
    @objc private func didTapLoginButton(_ sender: UIButton) {
        delegate?.didTapLogin()
    }
}

