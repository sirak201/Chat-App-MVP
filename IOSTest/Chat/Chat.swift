//
//  Chat.swift
//  IOSTest
//
//  Created by Sirak Zeray on 10/29/19.
//  Copyright © 2019 Sirak Zeray. All rights reserved.
//

import Foundation

class Chat {
    
    fileprivate let urlString = "http://dev.datechnologies.co/Tests/scripts/chat_log.php"
    weak var chatVCDelegate : RefreshDataDelegate? // *Chat <----> ChatVC*

    public var chats = [ChatModel]() {
        // Everytime this is reset it reloads the data in the view controller
        didSet{
            chatVCDelegate?.refreshData() // When data is set refreshs the view controller using a delegate
        }
    }
    
    /// Fetchs data from the API
    public func fetchData(completion : @escaping (Result < Bool , Error>) ->()) {
      
        // Returns if the base the base URL in not correct
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion(.failure(error!))
            }
           guard  let data = data else { return }
            
            do {
                let decode = try
                    JSONDecoder().decode(ChatData.self, from: data)
                self.chats = decode.chatModel // Sets array to data fetched
                completion(.success(true))

            } catch(let err){
                 completion(.failure(err))
            }
        }.resume() 
    }
    
 
    
    
    
    
    
    
    
    
    
    
}
