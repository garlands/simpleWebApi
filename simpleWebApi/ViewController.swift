//
//  ViewController.swift
//  simpleWebApi
//
//  Created by Masahiro Tamamura on 2019/08/20.
//  Copyright © 2019 Masahiro Tamamura. All rights reserved.
//

import UIKit

struct result:  Codable{
    let memberNo : String
}

struct JsonSample7: Codable{
    let errorCode: Int
    let errorMessage: String
    let result: result
}



class ViewController: UIViewController, ApiManagerDelegate {

    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!
    
    let apimgr :ApiManager = ApiManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.apimgr.delegate = self
    }

    @IBAction func touchUpSendButton(_ sender: UIButton) {
        apimgr.requestApi001()
    }
    
    func responseApi001(statusCode: Int, memberNo : String, state : Bool) {
        self.usernameLabel.text = memberNo
        self.statusLabel.text = "status code : \(statusCode)"
    }
}

