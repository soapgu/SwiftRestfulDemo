//
//  RestfulMoyaService.swift
//  SwiftRestfulDemo
//
//  Created by guhui on 2022/1/21.
//

import Foundation
import RxSwift
import Moya

var accessToken: String = ""

class RestfulMoyaService : RestfulAPI {
    let provider: MoyaProvider<MoyaInnerService>
    
    init(){
        let authPlugin = AccessTokenPlugin {  _ in accessToken }
        provider = MoyaProvider<MoyaInnerService>(plugins: [authPlugin])
    }
    
    func login(deviceCode: String) -> Single<String> {
         provider.rx.request(.login(deviceCode: deviceCode))
            .filterSuccessfulStatusCodes()
            .map(Dictionary<String,String>.self)
            .map{
                 $0["access_token"]!
            }
    }
    
    
    func getDevice(token: String) -> Single<Device> {
        accessToken = token
        print( accessToken )
        /*
        let device = Device(name: "MockDevice", id: "", room: Room(code: "", name: "MockRoom", id: ""))
        return Single.just(device)
        */
        return provider.rx.request(.getDevice(token: token))
            .filterSuccessfulStatusCodes()
            .map(Device.self)
    }
    
}
