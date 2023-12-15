//
//  LoginGlobalRepository.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/13.
//

import Foundation

import Foundation
import RxSwift

/// 로그인 데이터의 글로벌 저장소 (싱글턴)
public final class LoginGlobalRepository {
    
    //MARK: 싱글톤 클래스 선언
    
    static let shared: LoginGlobalRepository = LoginGlobalRepository()
    
    //init 으로 instance 생성하는 것을 막는 용도. (init() 함수 접근 제어자를 private로 지정)
    private init() { }
    
    
    //MARK: 로그인 데이터
    
    /// 로그인 결과 저장
    private var loggedInUserInfo: UserModel?
    
    /// 로그인 결과 구독하는 사람한테 정보 전달
    public let subscribableUserInfo: BehaviorSubject<UserModel?> = BehaviorSubject(value: nil)
    
    /// 외부에서 로그인 결과 전달
    public func saveLoggedInfo(_ model: UserModel?) {
        self.loggedInUserInfo = model
        self.subscribableUserInfo.on(.next(model))
    }
    
    
    //MARK: 로그인 유저의 액션
    
    /// 가장 최근 찾아 본 유저
    private var latestCheckedUser: UserModel? = nil
    
    /// 최근 찾아 본 유저 캐싱
    public func latestChecked(_ userInfo: UserModel?) {
        self.latestCheckedUser = userInfo
    }
}
