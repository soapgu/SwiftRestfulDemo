//
//  MoyaInnerService.swift
//  SwiftRestfulDemo
//
//  Created by guhui on 2022/1/21.
//

//import Foundation
import Moya

enum MoyaInnerService {
    case login(deviceCode: String)
    case getDevice(token: String)
}

extension MoyaInnerService : TargetType,AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        switch self {
        case .login(_):
            return nil
        case .getDevice(_):
            return .bearer
        }
    }
    
    var baseURL: URL {
        URL(string: "http://172.16.30.189/api")!
    }

    var path: String {
        switch self {
        case .login:
            return "/v2/oauth/device_authorization"
        case .getDevice:
            return "/v2/device"
        }
    }

    var method: Method {
        switch self {
        case .login:
            return .post
        case .getDevice:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .login(let deviceCode):
            let requestObject = ["device_code": deviceCode ,
                                 "client_id": "s365-device",
                                 "client_secret": "19335107-dad3-4fc3-8b66-b05a38b45fd2"]
            return .requestJSONEncodable(requestObject)
        case .getDevice:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}


