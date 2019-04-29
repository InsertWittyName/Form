//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

class TextInputFormField: FormField {
    var nextField: FormField?
    
    var onChange:((String) -> Void)?
    var onFinish:((String) -> Void)?
    
    var placeholderText: String
    var inputText: String?
    var returnKeyType: UIReturnKeyType = .next
    
    lazy var viewController: UIViewController = {
        return TextInputViewController(formField: self)
    }()
    
    init(placeholderText: String) {
        self.placeholderText = placeholderText
    }
}

//class TextInputFormFieldViewModel: FormFieldViewModel {
//    var onChange:((String) -> Void)?
//
//    let placeholderText: String
//    var inputText: String?
//
//    init(placeholderText: String) {
//        self.placeholderText = placeholderText
//    }
//}
