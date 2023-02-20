//
//  ChatAPI.swift
//  MannerChat
//
//  Created by Victor Lee on 2023/02/16.
//

import Alamofire
import Foundation
import TAKUUID

enum ChatAPI {

    static let version = "/v3"
    static let baseURL = "https://api-" + Bundle.main.SEND_BIRD_APP_ID + ".sendbird.com" + version
    static let userId = (TAKUUIDStorage.uuid ?? "") + "2"

    static func checkExistUser(completion: @escaping (Result<User, ApiError>) -> Void) {
//        guard let userId = userId else { return }
        guard let url = URL(string: baseURL + "/users" + "/\(userId)") else { return }

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Api-Token": Bundle.main.SEND_BIRD_API_TOKEN
        ]

        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: User.self) { response in
                guard let statusCode = response.response?.statusCode,
                      (200..<300).contains(statusCode)
                else {
                    completion(.failure(.badStatusCode(code: response.response?.statusCode ?? 0)))
                    return
                }
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                }
            }
            .resume()

    }

    static func createUser(nickname: String, completion: @escaping (Result<User, ApiError>) -> Void) {
        guard let url = URL(string: baseURL + "/users") else { return }
//        guard let userId = userId else { return }

        let headers: HTTPHeaders = [
            "Api-Token": Bundle.main.SEND_BIRD_API_TOKEN,
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]

        let body: Parameters = [
            "user_id": userId,
            "nickname": nickname,
            "profile_url": ""
        ]

        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .responseDecodable(of: User.self) { response in
                guard let statusCode = response.response?.statusCode,
                      (200..<300).contains(statusCode)
                else {
                    completion(.failure(.badStatusCode(code: response.response?.statusCode ?? 0)))
                    return
                }
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
    }

    static func changeNickname(nickname: String, completion: @escaping (Result<User, ApiError>) -> Void) {
//        guard let userId = userId else { return }
        guard let url = URL(string: baseURL + "/users" + "/\(userId)") else { return }


        let headers: HTTPHeaders = [
            "Api-Token": Bundle.main.SEND_BIRD_API_TOKEN,
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]

        let body: Parameters = [
            "nickname": nickname
        ]

        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .responseDecodable(of: User.self) { response in
                guard let statusCode = response.response?.statusCode,
                      (200..<300).contains(statusCode)
                else {
                    completion(.failure(.badStatusCode(code: response.response?.statusCode ?? 0)))
                    return
                }
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
    }

    static func joinChannel(completion: @escaping (Result<Channel, ApiError>) -> Void) {
        let channelUrl = "sendbird_group_channel_110387576_1f3463d33720cb98c2b8e3893d62f2e8f27e07bb"
        guard let url = URL(string: baseURL + "/group_channels" + "/\(channelUrl)" + "/join") else { return }

        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Api-Token": Bundle.main.SEND_BIRD_API_TOKEN
        ]

//        guard let userId = userId else { return }
        let body: Parameters = [
            "channel_url": channelUrl,
            "user_id": userId,
        ]

        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .responseDecodable(of: Channel.self) { response in
                guard let statusCode = response.response?.statusCode,
                      (200..<300).contains(statusCode)
                else {
                    completion(.failure(.badStatusCode(code: response.response?.statusCode ?? 0)))
                    return
                }
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
    }

    static func fetchMessages(completion: @escaping (Result<Messages, ApiError>) -> Void) {
        let channelUrl = "sendbird_group_channel_110387576_1f3463d33720cb98c2b8e3893d62f2e8f27e07bb"
        guard let url = URL(string: baseURL + "/group_channels" + "/\(channelUrl)" + "/messages") else { return }

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Api-Token": Bundle.main.SEND_BIRD_API_TOKEN
        ]

        let qeury: Parameters = [
            "message_ts": Date.timestamp
        ]

        AF.request(url, method: .get, parameters: qeury, encoding: URLEncoding(destination: .queryString), headers: headers)
            .responseDecodable(of: Messages.self) { response in
                guard let statusCode = response.response?.statusCode,
                      (200..<300).contains(statusCode)
                else {
                    completion(.failure(.badStatusCode(code: response.response?.statusCode ?? 0)))
                    return
                }
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    print(error)
                }
            }
            .resume()
    }

    static func sendMessage(message: String, completion: @escaping (Result<String, ApiError>) -> Void) {
        let channelUrl = "sendbird_group_channel_110387576_1f3463d33720cb98c2b8e3893d62f2e8f27e07bb"
        guard let url = URL(string: baseURL + "/group_channels" + "/\(channelUrl)" + "/messages") else { return }

        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Api-Token": Bundle.main.SEND_BIRD_API_TOKEN
        ]

//        guard let userId = userId else { return }
        let body: Parameters = [
            "message_type": "MESG",
            "user_id": userId,
            "message": message
        ]

        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.prettyPrinted, headers: headers)
            .response(completionHandler: { response in
                guard let statusCode = response.response?.statusCode,
                      (200..<300).contains(statusCode)
                else {
                    completion(.failure(.badStatusCode(code: response.response?.statusCode ?? 0)))
                    return
                }

                switch response.result {
                case .success:
                    completion(.success("success"))
                case .failure(let error):
                    print(error)
                }
            })
            .resume()
    }
    
}

extension ChatAPI {
    enum ApiError : Error {
        case wrongURL
        case noNickname
        case decodingError
        case badStatusCode(code: Int)

        var info : String {
            switch self {
            case .wrongURL:
                return "URL 주소가 적절하지 않습니다."
            case .noNickname:
                return "설정된 닉네임이 없습니다. 닉네임을 적어주세요."
            case .decodingError:
                return "디코딩 에러입니다."
            case .badStatusCode(let code):
                return "상태코드 에러 \(code)"
            }
        }
    }
}
