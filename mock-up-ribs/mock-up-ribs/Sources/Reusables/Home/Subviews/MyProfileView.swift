//
//  MyProfileView.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/14.
//

import UIKit

protocol MyProfileViewDelegate: AnyObject {
    func didTapFollowers()
    func didTapLogout()
}

class MyProfileView: UIScrollView, MyProfileLatestStateCellDelegate {
    
    public weak var eventDelegate: MyProfileViewDelegate?
    
    private let container: UIStackView = {
       let s = UIStackView()
        s.axis = .vertical
        s.alignment = .fill
        s.distribution = .fill
        s.spacing = 12
        s.backgroundColor = .systemGray6
        s.layoutMargins = .init(top: 32, left: 16, bottom: 16, right: 16)
        s.isLayoutMarginsRelativeArrangement = true
        return s
    }()
    
    private lazy var logoutableButton: UIButton = {
        let b = UIButton()
        b.setTitle("로그아웃", for: .normal)
        b.contentHorizontalAlignment = .left
        b.titleEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 0)
        b.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        b.setTitleColor(.lightGray, for: .normal)
        b.backgroundColor = .white
        b.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        b.roundCorners(10)
        return b
    }()

    private let myInfo: UserModel?
    
    init(myInfo: UserModel?) {
        self.myInfo = myInfo
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        showsVerticalScrollIndicator = false
        
        addSubview(container)
        
        let topCell = MyProfileTopCell(
            id: myInfo?.id,
            name: myInfo?.name,
            userName: myInfo?.username,
            email: myInfo?.email
        )
        
        let stateCell = MyProfileLatestStateCell()
        stateCell.delegate = self
        
        let subCell = UserDetailCell(
            addr: myInfo?.address,
            company: myInfo?.company,
            phone: myInfo?.phone,
            website: myInfo?.website
        )
        
        container.addArrangedSubview(topCell)
        container.addArrangedSubview(stateCell)
        container.addArrangedSubview(subCell)
        container.addArrangedSubview(logoutableButton)
        
        setupLayouts()
        
        stateCell.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(48)
        }
    }
    
    private func setupLayouts() {
        container.snp.makeConstraints { make in
            make.top.equalTo(self.contentLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(self.contentLayoutGuide.snp.bottom)
        }
    }
    
    @objc private func didTapLogout() {
        eventDelegate?.didTapLogout()
    }
    
    //MARK: 델리게이트 메소드
    
    func didTapFollowers() {
        eventDelegate?.didTapFollowers()
    }
}
