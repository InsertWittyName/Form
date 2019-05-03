//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

class AddressBookFormSection: FormSection {
    var fields: [FormField]
    var title: String?
    
    init(title: String? = nil, fields: [FormField]) {
        self.title = title
        self.fields = fields
    }
    
    lazy var viewController: UIViewController = {
        return AddressBookFormSectionController(formField: self)
    }()
}
