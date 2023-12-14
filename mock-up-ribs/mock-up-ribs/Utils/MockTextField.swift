//
//  MockTextField.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/14.
//

import UIKit

public class MockTextField: UITextField {
    
    private let validateLabel: UILabel = {
       let l = UILabel()
        l.text = ""
        l.textColor = .systemRed
        l.font = .systemFont(ofSize: 12, weight: .regular)
        l.alpha = 0.0
        return l
    }()
    
    init() {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        clearButtonMode = .never
        backgroundColor = .white
        borderStyle = .none
        layer.cornerRadius = 8.0
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerCurve = .continuous
        layer.borderWidth = 1.2
        addLeftPadding(width: 10.0)
        
        addSubview(validateLabel)
        
        validateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
        }
    }
    
    public func showValidate(with message: String, rightViewAlways: Bool = false) {
        self.layer.borderColor = UIColor.systemRed.cgColor
        
        UIView.animate(withDuration: 0.25, delay: 0.1) { [weak self] in
            self?.validateLabel.text = message
            self?.validateLabel.alpha = 1.0
            if !rightViewAlways { self?.rightView?.alpha = 0.0 }
        } completion: { _ in }
    }
    
    public func hideValidate(rightViewAlways: Bool = false) {
        UIView.animate(withDuration: 0.25, delay: 0.1) { [weak self] in
            self?.validateLabel.text = ""
            self?.validateLabel.alpha = 0.0
            if !rightViewAlways { self?.rightView?.alpha = 0.0 }
        } completion: { _ in }
    }
    
    public func hideValidateWithActive(_ isActive: Bool, rightViewAlways: Bool = false) {
        self.withActive(isActive)
        hideValidate(rightViewAlways: rightViewAlways)
    }
    
    public func setupValidateCheck() {
        rightViewImage(
            AssetsProxy.check_select_green
                .image()
                .withRenderingMode(.alwaysOriginal),
                //.resizeImage(to: .init(width: 18, height: 18)),
            imageWidth: 16,
            padding: 5
        )
        rightView?.alpha = 0.0
    }
    
    public func showValidateCheck() {
        self.layer.borderColor = UIColor.lightGray.cgColor
        UIView.animate(withDuration: 0.25, delay: 0) { [weak self] in
            self?.rightView?.alpha = 1.0
        }
    }
    
    public func hideValidateCheck() {
        UIView.animate(withDuration: 0.25, delay: 0) { [weak self] in
            self?.rightView?.alpha = 0.0
        }
    }
}

extension UITextField {
    
    /// width 값에 원하는 padding 값을 넣어줍니다.
    func addLeftPadding(width: CGFloat) {
        let paddedView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
        self.leftView = paddedView
        self.leftViewMode = .always
    }
    
    /// 활성화 시에 경계선 컬러 변경
    public func withActive(_ isActive: Bool) {
        if isActive {
            self.layer.borderColor = UIColor.darkGray.cgColor
        } else {
            self.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    /// 오른쪽 체크마크 를 위한 세팅
    func rightViewImage(_ image: UIImage?, imageWidth: CGFloat, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: padding, y: 0, width: imageWidth, height: frame.height)
        imageView.contentMode = .center
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + 2 * padding, height: frame.height))
        containerView.addSubview(imageView)
        rightView = containerView
        rightViewMode = .unlessEditing
    }
}
