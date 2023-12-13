//
//  NetworkManager.swift
//  mock-up-ribs
//
//  Created by dongkyulee on 2023/12/12.
//

import UIKit
import Moya

/// 네트워크 모듈의 공통 클래스
final class NetworkManager {
    
    /// 싱글톤 클래스 선언
    static let shared: NetworkManager = NetworkManager()
    
    /// API 도메인 주소 리턴
    ///
    public func domain(_ domainType: MockDomain = .default) -> String {
        return domainType.path
    }
    
    /// API 헤더 리턴
    public func header(_ headerType: MockHeader = .common) -> Dictionary<String, String> {
        return headerType.value
    }
    
    //init 으로 instance 생성하는 것을 막는 용도. (init() 함수 접근 제어자를 private로 지정)
    private init() { }
}

//MARK: - API 도메인 주소 관리
public enum MockDomain {
    case `default`
}

extension MockDomain {
    public var path: String {
        switch self {
    #if STAGE
        case .default: return "https://jsonplaceholder.typicode.com/"
    #else  //REAL
        case .default: return "https://jsonplaceholder.typicode.com/"
    #endif
        }
    }
}

//MARK: - API 헤더 관리
public enum MockHeader {
    case common
}

extension MockHeader {
    public var value: [String: String] {
        switch self {
        case .common:
            return [
                "separatorDevice": "iOS",
                "appVersion" : Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "",
                "deviceOsVersion" : UIDevice.current.systemVersion,
                "deviceName" : UIDevice.current.name,
                "Content-Type" : "application/json"
            ]
        }
    }
}


//MARK: - 리스폰스 파싱 메소드
extension NetworkManager {
    
    /// 네트워크 리스폰스 데이터 파싱하는 제너릭 메소드
    public func response<T: Codable>(
        _ result: Result<Response, MoyaError>,
        instance: T.Type,
        completion: @escaping (T?, String?) -> Void
    ) {
        switch result {
        case .success(let response):
            do {
                let resultData = try response.map(T.self)
                completion(resultData, nil)
            } catch { // 에러 팝업 전달
                completion(nil, ResultMessage.common.desc)
            }
        case .failure(_): // 에러 팝업 전달
            completion(nil, ResultMessage.common.desc)
        }
    }
}

//MARK: - 에러 메세지 유틸리티
/// 에러 팝업 노출에 사용하는 유틸 메소드
public enum ResultMessage {
    case common
}

extension ResultMessage {
    
    var desc: String {
        switch self {
        case .common: return "일시적인 오류입니다. 다시 시도해주세요."
        }
    }
}
