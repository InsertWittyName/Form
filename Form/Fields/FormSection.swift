//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import Foundation

class FormSection {
    let fields: [FormField]
    let title: String
    
    init(title: String, fields: [FormField]) {
        self.title = title
        self.fields = fields
    }
}
