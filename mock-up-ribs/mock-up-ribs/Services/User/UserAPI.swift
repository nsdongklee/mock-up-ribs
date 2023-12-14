//
//  UserAPI.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import Foundation
import Moya

public enum UserAPI {
    /// 팔로우한 유저 리스트
    case users
    /// 유저 디테일
    /// - Parameter id: 유저 ID
    case user(id: Int)
    /// 로그인
    /// - Parameter id: 회원 ID
    case login(id: Int)
}

extension UserAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: NetworkManager.shared.domain(.default))!
    }
    
    public var path: String {
        switch self {
        case .users: return "/users"
        case .user(let id): return "/users/\(id)"
        case .login(let id): return "/users/\(id)"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .users: return .get
        case .user(_): return .get
        case .login(_): return .get
        }
    }
    
    public var task: Moya.Task {
        switch self {
        case .users:
            return .requestPlain
        case .user(_):
            return .requestPlain
        case .login(_):
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return NetworkManager.shared.header(.common)
    }
}
