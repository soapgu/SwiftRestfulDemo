//
//  ViewController.swift
//  SwiftRestfulDemo
//
//  Created by guhui on 2022/1/20.
//

import Cocoa
import RxSwift

class ViewController: NSViewController {
    var disposeBag = DisposeBag()
    var api: RestfulAPI = RestfulMoyaService()
    @IBOutlet var msgLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.login(deviceCode: "D9C3F5FF-664B-4DCA-968B-37228FA1C460")
            .flatMap{
                [unowned self] token in
                self.api.getDevice(token: token)
            }
            .subscribe(onSuccess:{
                [weak msgLabel] device in
                msgLabel?.stringValue = "\(device.name) in \(device.room.name)"
            })
            .disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

