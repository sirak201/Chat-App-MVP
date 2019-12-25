//
//  UITextViewPadding.swift
//  IOSTest
//
//  Created by Sirak Zeray on 10/30/19.
//  Copyright © 2019 Sirak Zeray. All rights reserved.
//

import Foundation
import UIKit

class UITextViewPadding : UITextView {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8 , right: 8)
  }
}
