//
//  LoginViewModel.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/14.
//

import Foundation
import RxSwift
import Moya

class LoginViewModel: NSObject {
    
    private let provider = MoyaProvider<UserAPI>()
    
    /// 아이디 검증 여부 스트림
    public let isValidID: BehaviorSubject<(String?, Bool)> = BehaviorSubject(value: (nil, false))
    
    /// 비밀번호 검증 여부 스트림
    public let isValidPW: BehaviorSubject<(String?, Bool)> = BehaviorSubject(value: (nil, false))
    
    override init() {
        super.init()
    }
    
    public func checkInput(id: String?) {
        if let id = id {
            isValidID.on(.next((id, Jarvis.shared.validate(id: id))))
        } else {
            isValidID.on(.next((nil, false)))
        }
    }
    
    public func checkInput(pw: String?) {
        if let pw = pw {
            isValidPW.on(.next((pw, Jarvis.shared.validate(pw: pw))))
        } else {
            isValidPW.on(.next((nil, false)))
        }
    }
    
    public func inputID() -> Int {
        let id = try? isValidID.value().0
        return Int(id ?? "0") ?? -1
    }
    
    public func inputPW() -> String {
        let pw = try? isValidPW.value().0
        return pw ?? ""
    }
    
    public func login(id: Int, pw: String, completion: @escaping (UserModel?) -> Void) {
        provider.request(.login(id: id)) { result in
            NetworkManager.shared.response(result, instance: UserModel.self) { res, err in
                LoginGlobalRepository.shared.saveLoggedInfo(res)
                completion(res)
            }
        }
    }
}
