//
//  ChatCell.swift
//  IOSTest
//
//  Created by Sirak Zeray on 10/29/19.
//  Copyright © 2019 Sirak Zeray. All rights reserved.
//

import UIKit
import SDWebImage



class ChatCell: UICollectionViewCell {
    
    //MARK: - OUTLETS
    @IBOutlet weak fileprivate var profilePictureIV: UIImageView!
    @IBOutlet weak var messageTV: UITextViewPadding!
    @IBOutlet weak var usernameLabel: PaddingLabel!
    
    var chat : ChatModel? {
        didSet {
            // Checking if the chat is not set to nil
            if chat != nil {
                setThumbnail(thumbnailUrl: chat!.avatar_url)
                usernameLabel.text = chat!.name
                messageTV.text = chat!.message
            }
        }
    }
    

    

    override func awakeFromNib() {
        super.awakeFromNib()
        setOutlet()
    }
    
    //MARK: -FUNCTIONS
    
    /// Sets outlets attribuites
    fileprivate func setOutlet(){
        profilePictureIV.clipsToBounds = true
        profilePictureIV.contentMode = .scaleAspectFill
        profilePictureIV.layer.cornerRadius = profilePictureIV.frame.height / 2
        messageTV.layer.cornerRadius = 8
        messageTV.layer.borderWidth = 1
        messageTV.layer.borderColor = #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)

        
    }
    
    /// Featch image using the URL passes in and sets it to the imageview 
    fileprivate func setThumbnail(thumbnailUrl url : String) {
           let url = URL(string: url)
        SDWebImageManager.shared.loadImage(with: url, options: .continueInBackground, progress: nil) {(image, _, _, _, _, _) in
               
            self.profilePictureIV.image = image
           }
       }
    
    
    
}



