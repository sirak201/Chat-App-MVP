import UIKit

@IBDesignable
class TextFieldExtended : UITextField {
    

    
    let padding = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 10)
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
            
        // Sets the placeholder textcolor to what the tinit colot is
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ? placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor : tintColor])
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
    
   

    
}



