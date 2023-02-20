//
//  API+.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/16.
//

import Foundation

extension Bundle {

    var SEND_BIRD_APP_ID: String {
        guard let file = self.path(forResource: "Info", ofType: "plist") else { return "" }

        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["SEND_BIRD_APP_ID"] as? String else {
            fatalError("API_KEY_ERROR")
        }
        return key
    }

    var SEND_BIRD_API_TOKEN: String {
        guard let file = self.path(forResource: "Info", ofType: "plist") else { return "" }

        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["SEND_BIRD_API_TOKEN"] as? String else {
            fatalError("API_KEY_ERROR")
        }
        return key
    }
}
