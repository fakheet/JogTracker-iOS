//
// Created by mage on 22.11.2021.
//

import Foundation

struct JogDTO: Codable {
    let id: Int
    let userId: String
    let distance: Float
    let time: Int
    let date: Int
}

struct JogTimestampedDTO: Decodable {
    let id: Int
    let userId: Int
    let distance: Float
    let time: Int
    let date: String
    let createdAt: String
    let updatedAt: String
}

struct SyncGetResponse: Codable {
    let jogs: [JogDTO]
}

struct LoginUUIDResponseDTO: Decodable {
    let accessToken: String
}