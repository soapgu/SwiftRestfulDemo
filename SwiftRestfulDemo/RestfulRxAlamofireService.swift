//
//  RestfulRxAlamofireService.swift
//  SwiftRestfulDemo
//
//  Created by guhui on 2022/1/20.
//

import Foundation
import RxAlamofire
import RxSwift
import Alamofire

class RestfulRxAlamofireService : RestfulAPI {
    
    let baseUrl = "http://172.16.30.189/api"

    func login(deviceCode: String) -> Single<String> {
    
        let requestObject = ["device_code": deviceCode ,
                             "client_id": "s365-device",
                             "client_secret": "19335107-dad3-4fc3-8b66-b05a38b45fd2"]
        
        let auth: Observable<[String: String]> = RxAlamofire.decodable(.post, "\(baseUrl)/v2/oauth/device_authorization",parameters: requestObject,encoding: JSONEncoding.default)//.debug()
        return auth.map{
            item in
            if let token = item["access_token"]{
                return token
            }
            throw MyError.errorjson
        }
        .asSingle()
    }

    func getDevice(token: String) -> Single<Device> {
        return RxAlamofire.decodable(.get, "\(baseUrl)/v2/device", headers: ["Authorization":"Bearer \(token)"]).asSingle()
    }
    
}
