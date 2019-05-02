//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

class PickerInputFormField: FormField {
    var onChange:((String) -> Void)?
    var onFinish:((String) -> Void)?
    
    var placeholderText: String
    var options: [PickerOption]
    
    lazy var viewController: UIViewController = {
        return PickerInputViewController(formField: self)
    }()
    
    init(placeholderText: String, options: [PickerOption]) {
        self.placeholderText = placeholderText
        self.options = options
    }
}
