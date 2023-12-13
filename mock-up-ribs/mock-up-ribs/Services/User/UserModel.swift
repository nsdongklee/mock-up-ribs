//
//  UserModel.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import Foundation

/// 유저 정보 조회 모델
public struct UserModel: Codable {
    var id: Int?
    var name: String?
    var username: String?
    var email: String?
    var phone: String?
    var website: String?
    
    var address: Address?
    
    struct Address: Codable {
        var street: String?
        var suite: String?
        var city: String?
        var zipcode: String?
        var geo: Geo?
        
        struct Geo: Codable {
            var lat: String?
            var lng: String?
        }
    }
    
    var company: Company?
    
    struct Company: Codable {
        var name: String?
        var catchPhrase: String?
        var bs: String?
    }
}

