//
//  MyProfileTopCell.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/18.
//

import UIKit

protocol MyProfileTopCellDelegate: AnyObject {
}

class MyProfileTopCell: UIStackView {
    
    public weak var delegate: MyProfileTopCellDelegate?

    private let iconContainerView: UIView = {
        let v = UIView()
        return v
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView(image: AssetsProxy.unknown_user.image())
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
//    private let verticalStackView: UIStackView = {
//        let s = UIStackView()
//        s.axis = .vertical
//        s.alignment = .fill
//        s.distribution = .fill
//        s.spacing = 0
//        s.backgroundColor = .white
//        s.layoutMargins = .init(top: 8, left: 0, bottom: 8, right: 0)
//        s.isLayoutMarginsRelativeArrangement = true
//        return s
//    }()
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = self.name
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return lbl
    }()
    
    private lazy var userNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = self.userName
        lbl.textColor = .lightGray
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return lbl
    }()
    
    private lazy var emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = self.email
        lbl.textColor = .darkGray
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return lbl
    }()
    
    //MARK: 생성자
    
    private let id: Int?
    private let name: String?
    private let userName: String?
    private let email: String?
    
    init(id: Int?, name: String?, userName: String?, email: String?) {
        self.id = id
        self.name = name
        self.userName = userName
        self.email = email
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 0
        backgroundColor = .white
        layoutMargins = .init(top: 24, left: 12, bottom: 24, right: 12)
        isLayoutMarginsRelativeArrangement = true
        roundCorners(16)
        
        addArrangedSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        addArrangedSubview(nameLabel)
        addArrangedSubview(userNameLabel)
        addArrangedSubview(emailLabel)
        
        iconContainerView.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(72)
            make.center.equalToSuperview()
        }
        
        setCustomSpacing(18, after: iconContainerView)
        setCustomSpacing(8, after: userNameLabel)
    }
}
