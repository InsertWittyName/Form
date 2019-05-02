//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

class TextInputFormField: FormField {
    var onChange:((String) -> Void)?
    var onFinish:((String) -> Void)?
    
    var placeholderText: String
    var inputText: String?
    var returnKeyType: UIReturnKeyType = .next
    var keyboardType: UIKeyboardType = .default
    var textContentType: UITextContentType?
    
    var isValid: Bool = false {
        didSet {
            viewController.state = isValid ? .valid : .invalid
        }
    }
    
    lazy var viewController: ValidatableViewController = {
        return TextInputViewController(formField: self)
    }()
    
    init(placeholderText: String) {
        self.placeholderText = placeholderText
    }
}
