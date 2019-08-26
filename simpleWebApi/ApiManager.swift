//
//  ApiManager.swift
//  simpleWebApi
//
//  Created by Masahiro Tamamura on 2019/08/20.
//  Copyright © 2018年 Masahiro Tamamura. All rights reserved.
//

import UIKit

protocol ApiManagerDelegate {
    func responseApi001(statusCode: Int, memberNo : String, state : Bool)
}

extension ApiManagerDelegate {
    func responseApi001(statusCode: Int, memberNo : String, state : Bool) {
        print("extension responseApi001")
    }
}

class ApiManager: NSObject {
    
    var delegate : ApiManagerDelegate?
    static let sharedInstance: ApiManager = ApiManager()
    private override init() {
        super.init()
    }
    
    func requestApi001(){
        let apiUrl = URL(string: "https://(your test server)/7.json")!
        /* 7.json 
         {
         "errorCode": 0,
         "errorMessage": "",
         "result": {
         "memberNo": "G123456789"
         }
         }
         */
        var request = URLRequest(url: apiUrl)
        request.addValue("Accept:application/json", forHTTPHeaderField: "Content-type")
        request.addValue("Accept:application/json", forHTTPHeaderField: "Accept")
        request.addValue("utf-8", forHTTPHeaderField: "Accept-Charset")
        //        request.addValue("Bearer \(token_str)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {data, response, err in
            if (err == nil) {
                guard let data = data, let resp = response as? HTTPURLResponse else { return }
                do {
                    let json = try JSONDecoder().decode(JsonSample7.self, from: data)
                    DispatchQueue.main.async {
                        let res = json.result
                        self.delegate?.responseApi001(statusCode: resp.statusCode, memberNo:res.memberNo, state : true )
                    }
                } catch let err {
                    print("Err", err)
                    self.delegate?.responseApi001(statusCode: 0, memberNo:"", state : false )
                }
            } else {
                self.delegate?.responseApi001(statusCode: 0, memberNo:"", state : false )
            }
        }.resume()
    }
}
