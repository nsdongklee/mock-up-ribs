//
//  MyProfileLatestStateCell.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/18.
//

import UIKit

protocol MyProfileLatestStateCellDelegate: AnyObject {
    func didTapFollowers()
}

class MyProfileLatestStateCell: UIStackView {
    
    public weak var delegate: MyProfileLatestStateCellDelegate?
    
    private let titleStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.alignment = .fill
        s.distribution = .fillEqually
        s.spacing = 0
        s.backgroundColor = .white
        s.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        s.isLayoutMarginsRelativeArrangement = true
        return s
    }()
    
    private lazy var latestViewedTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "최근 검색한 팔로워"
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return lbl
    }()
    
    private let myFollowersTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "내 팔로워 목록"
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return lbl
    }()
    
    private let subInfoStackView: UIStackView = {
        let s = UIStackView()
        s.axis = .horizontal
        s.alignment = .fill
        s.distribution = .fillEqually
        s.spacing = 6
        s.backgroundColor = .white
        s.layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        s.isLayoutMarginsRelativeArrangement = true
        return s
    }()
    
    private lazy var latestViewedSubLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "-"
        lbl.textColor = .darkGray
        lbl.textAlignment = .center
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byCharWrapping
        return lbl
    }()
    
    private let myFollowersButtonContainer: UIView = {
       let v = UIView()
        return v
    }()
    
    private lazy var myFollowersButton: UIButton = {
        let b = UIButton()
        b.setTitle("팔로워", for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .systemBlue
        b.addTarget(self, action: #selector(didTapFollowerButton), for: .touchUpInside)
        b.roundCorners()
        return b
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
        spacing = 0
        backgroundColor = .white
        layoutMargins = .init(top: 8, left: 8, bottom: 8, right: 8)
        isLayoutMarginsRelativeArrangement = true
        roundCorners(16)
        
        addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(latestViewedTitleLabel)
        titleStackView.addArrangedSubview(myFollowersTitleLabel)
        
        addArrangedSubview(subInfoStackView)
        subInfoStackView.addArrangedSubview(latestViewedSubLabel)
        subInfoStackView.addArrangedSubview(myFollowersButtonContainer)
        myFollowersButtonContainer.addSubview(myFollowersButton)
        
        myFollowersButtonContainer.snp.makeConstraints { make in
            make.height.equalTo(30)
        }
        
        myFollowersButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(72)
        }
    }
    
    @objc private func didTapFollowerButton(_ sender: UIButton) {
        delegate?.didTapFollowers()
    }
}
