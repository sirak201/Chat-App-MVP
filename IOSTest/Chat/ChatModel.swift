//
//  ChatModel.swift
//  IOSTest
//
//  Created by Sirak Zeray on 10/29/19.
//  Copyright © 2019 Sirak Zeray. All rights reserved.
//

import Foundation

struct ChatData : Decodable {
    var chatModel : [ChatModel]
    
    private enum CodingKeys : String, CodingKey {
           case chatModel = "data"
       }
}
struct ChatModel : Decodable {
    var user_id: String
    var name: String
    var avatar_url: String
    var message: String
}
