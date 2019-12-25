//
//  ChatVC.swift
//  IOSTest
//
//  Created by Sirak Zeray on 10/29/19.
//  Copyright © 2019 Sirak Zeray. All rights reserved.
//

import UIKit

fileprivate let cellId = "chatCellID"
fileprivate let nibID = "ChatCell"
fileprivate let totalCellPadding : CGFloat =  16 + 4 + 16 + 30


class ChatVC :  UIViewController  ,  RefreshDataDelegate {
    //MARK: - Varables and Outlets
     let chat = Chat()
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    //MARK: - LifeCylce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Sets Delegate to Self *Chat <----> ChatVC*
        chat.chatVCDelegate = self
        configureCollectionView()
       
        chat.fetchData { (res) in
            switch res {
            case .success(_):
                print("Success") // Remove waiter
            case .failure(_):
                print("Failure") // Display an Error
            }
        }
    }
    
    //MARK: - Functions
    
    /// Configures Collection view
    fileprivate func configureCollectionView() {
          mainCollectionView.delegate = self
          mainCollectionView.dataSource = self
          mainCollectionView.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
          mainCollectionView.register(UINib.init(nibName: nibID, bundle: nil) , forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func getTextHeight(text : String) -> CGFloat{
        
        let size = CGSize(width: view.frame.width, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)], context: nil)
        
        return estimateFrame.height
    }
    
    
    //MARK: - Delegate
    func refreshData() {
        DispatchQueue.main.async {
            self.mainCollectionView.reloadData()
        }
    }

   

}

//MARK: - Delegate and DataSource for CollectionView

extension ChatVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chat.chats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellData = chat.chats[indexPath.row]
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatCell)
        cell.chat = cellData
    
        return cell
    }
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let messageText = chat.chats[indexPath.row].message
 
        return CGSize(width: view.frame.width, height: getTextHeight(text: messageText) + totalCellPadding)
       }
       

    

       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 24
       }
    
 
    
    
}
