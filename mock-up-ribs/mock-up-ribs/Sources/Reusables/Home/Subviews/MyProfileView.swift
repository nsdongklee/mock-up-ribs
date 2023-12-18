//
//  MyProfileView.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/14.
//

import UIKit

class MyProfileView: UIScrollView {
    
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
        addSubview(container)
        
        let topCell = MyProfileTopCell(
            id: myInfo?.id,
            name: myInfo?.name,
            userName: myInfo?.username,
            email: myInfo?.email
        )
        
        let subCell = UserDetailCell(
            addr: myInfo?.address,
            company: myInfo?.company,
            phone: myInfo?.phone,
            website: myInfo?.website
        )
        
        container.addArrangedSubview(topCell)
        container.addArrangedSubview(subCell)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        container.snp.makeConstraints { make in
            make.top.equalTo(self.contentLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(self.contentLayoutGuide.snp.bottom)
        }
    }
}
