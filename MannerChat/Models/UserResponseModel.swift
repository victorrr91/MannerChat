//
//  UserResponseModel.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/16.
//

import Foundation

struct User: Codable {
    let userID, nickname, profileURL: String?
    let isOnline, isActive, isShadowBlocked, isHideMeFromFriends: Bool?
    let lastSeenAt, endAt, startAt, createdAt: Int?

    enum CodingKeys: String, CodingKey {
        case isOnline = "is_online"
        case userID = "user_id"
        case isActive = "is_active"
        case lastSeenAt = "last_seen_at"
        case nickname
        case profileURL = "profile_url"
        case createdAt = "created_at"
        case isHideMeFromFriends = "is_hide_me_from_friends"
        case isShadowBlocked = "is_shadow_blocked"
        case endAt = "end_at"
        case startAt = "start_at"
    }
}
