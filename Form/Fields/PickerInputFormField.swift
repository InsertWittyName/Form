//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

class PickerInputFormField: FormField {
    var onChange:((String) -> Void)?
    var onFinish:((String) -> Void)?
    
    var placeholderText: String
    var returnKeyType: UIReturnKeyType = .next
    
    lazy var viewController: UIViewController = {
        return PickerInputViewController(formField: self)
    }()
    
    init(placeholderText: String) {
        self.placeholderText = placeholderText
    }
}
