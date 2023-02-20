//
//  UUID+.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/16.
//

import Foundation
import TAKUUID

extension TAKUUIDStorage {
    static let uuid = TAKUUIDStorage.sharedInstance().findOrCreate()
}
