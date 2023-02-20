//
//  ChannelResponseModel.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/17.
//

import Foundation

struct Channel: Codable {
    let channelURL, name, customType, coverURL: String?
    let createdAt, participantCount, maxLengthMessage, memberCount, unreadMessageCount: Int?
    let freeze: Bool?

    enum CodingKeys: String, CodingKey {
        case channelURL = "channel_url"
        case name
        case coverURL = "cover_url"
        case createdAt = "created_at"
        case participantCount = "participant_count"
        case maxLengthMessage = "max_length_message"
        case memberCount = "member_count"
        case customType = "custom_type"
        case unreadMessageCount = "unread_message_count"
        case freeze
    }
}

// MARK: - Welcome
struct Messages: Codable {
    let messages: [Message]?
}

// MARK: - Message
struct Message: Codable {
    let type: String?
    let messageID: Int?
    let message: String?
    let createdAt: Int?
    let user: ChatUser?
    let channelURL, channelType: String?
    let messageEvents: MessageEvents?

    enum CodingKeys: String, CodingKey {
        case type
        case messageID = "message_id"
        case message
        case createdAt = "created_at"
        case user
        case channelURL = "channel_url"
        case channelType = "channel_type"
        case messageEvents = "message_events"
    }
}

// MARK: - MessageEvents
struct MessageEvents: Codable {
    let sendPushNotification: String?
    let updateUnreadCount, updateMentionCount, updateLastMessage: Bool?

    enum CodingKeys: String, CodingKey {
        case sendPushNotification = "send_push_notification"
        case updateUnreadCount = "update_unread_count"
        case updateMentionCount = "update_mention_count"
        case updateLastMessage = "update_last_message"
    }
}

// MARK: - User
struct ChatUser: Codable {
    let userID, profileURL, nickname: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case profileURL = "profile_url"
        case nickname
    }
}
