//
//  UserViewModel.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import Foundation
import RxSwift
import Moya

class UserViewModel: NSObject {
    
    private let provider = MoyaProvider<UserAPI>()
    
    public let followersRx: BehaviorSubject<[UserModel]?> = BehaviorSubject(value: nil)
    
    override init() {
        super.init()
    }
    
    public func followers() {
        provider.request(.users) { result in
            NetworkManager.shared.response(result, instance: [UserModel].self) { [weak self] res, err in
                if let res = res {
                    self?.followersRx.on(.next(res))
                } else {
                    self?.followersRx.on(.next(nil))
                }
            }
        }
    }
    
    public func login(id: Int, completion: @escaping (UserModel?) -> Void) {
        provider.request(.login(id: id)) { result in
            NetworkManager.shared.response(result, instance: UserModel.self) { res, err in
                completion(res)
            }
        }
    }
    
    public func user(id: Int, completion: @escaping (UserModel?) -> Void) {
        provider.request(.user(id: id)) { result in
            NetworkManager.shared.response(result, instance: UserModel.self) { res, err in
                completion(res)
            }
        }
    }
}
