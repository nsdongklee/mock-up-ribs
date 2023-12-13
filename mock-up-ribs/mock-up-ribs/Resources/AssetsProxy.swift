//
//  AssetsProxy.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import UIKit

//MARK: - Assets 에 담아둔 이미지에 접근하는 프록시 역할
public enum AssetsProxy: String {
    case unknown_user = "unknown_user"
    case house = "house"
}

//MARK: - 관련 메소드
extension AssetsProxy {
    
    public func image() -> UIImage {
        var name = ""
        switch self {
        default:
            name = self.rawValue
        }
        return UIImage(named: name) ?? UIImage()
    }
}
