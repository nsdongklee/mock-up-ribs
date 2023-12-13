//
//  UserDetailCell.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import UIKit

class UserDetailCell: UIStackView {
    
    //MARK: 생성자
    
    private let addr: UserModel.Address?
    private let company: UserModel.Company?
    private let phone: String?
    private let website: String?
    
    init(addr: UserModel.Address?, company: UserModel.Company?, phone: String?, website: String?) {
        self.addr = addr
        self.company = company
        self.phone = phone
        self.website = website
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
        layoutMargins = .init(top: 6, left: 16, bottom: 16, right: 16)
        isLayoutMarginsRelativeArrangement = true
        roundCorners(16)
        
        configure()
    }
    
    private func configure() {
        UserDetailType.allCases.forEach { type in
            let horizontal: UIStackView = {
                let s = UIStackView()
                s.axis = .horizontal
                s.alignment = .fill
                s.distribution = .fill
                s.spacing = 12
                s.backgroundColor = .white
                s.layoutMargins = .init(top: 8, left: 0, bottom: 8, right: 0)
                s.isLayoutMarginsRelativeArrangement = true
                return s
            }()
            
            let iconImage: UIImageView = {
                let iv = UIImageView(image: type.image)
                iv.contentMode = .scaleAspectFit
                iv.backgroundColor = .clear
                iv.translatesAutoresizingMaskIntoConstraints = false
                iv.snp.makeConstraints { make in
                    make.width.equalTo(16)
                }
                return iv
            }()
            
            let descLabel: UILabel = {
                let lbl = UILabel()
                lbl.text = type.title
                lbl.textColor = .black
                lbl.textAlignment = .left
                lbl.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
                return lbl
            }()
            
            var subDesc = ""
            switch type {
            case .addr:
                subDesc = (self.addr?.city ?? "") + ", " + (self.addr?.street ?? "")
            case .company:
                subDesc = self.company?.name ?? ""
            case .phone:
                subDesc = self.phone ?? ""
            case .website:
                subDesc = self.website ?? ""
            }
            
            let subLabel: UILabel = {
                let lbl = UILabel()
                lbl.text = subDesc
                lbl.textColor = .darkGray
                lbl.textAlignment = .left
                lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
                return lbl
            }()
            
            addArrangedSubview(horizontal)
            
            let spliter = Jarvis.shared.addSpliter()
            addArrangedSubview(spliter)
            setCustomSpacing(12, after: spliter)
            
            horizontal.addArrangedSubview(iconImage)
            horizontal.addArrangedSubview(descLabel)
            
            addArrangedSubview(subLabel)
            
            setCustomSpacing(12, after: subLabel)
            
            descLabel.snp.makeConstraints { make in
                make.height.equalTo(descLabel.intrinsicContentSize.height)
            }
        }
    }
}

enum UserDetailType: CaseIterable {
    case addr
    case company
    case phone
    case website
    
    var image: UIImage {
        switch self {
        case .addr: return AssetsProxy.house.image()
        case .company: return AssetsProxy.house.image()
        case .phone: return AssetsProxy.house.image()
        case .website: return AssetsProxy.house.image()
        }
    }
    
    var title: String {
        switch self {
        case .addr: return "Address"
        case .company: return "Company"
        case .phone: return "Phone"
        case .website: return "Website"
        }
    }
}
