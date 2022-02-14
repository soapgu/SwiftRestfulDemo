//
//  RestfulAPI.swift
//  SwiftRestfulDemo
//
//  Created by guhui on 2022/1/20.
//

import Foundation
import RxSwift

protocol RestfulAPI {
    func login(deviceCode: String) -> Single<String>
    func getDevice(token: String) -> Single<Device>
}

