//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import Foundation

class ContactFormViewModel: FormViewModel {
    var fields = [FormField]()
    var onUpdate: (() -> Void)?
    
    init() {
        let firstNameTextInput = TextInputFormField(placeholderText: "First name")
        
        firstNameTextInput.onChange = { [weak self] input in
            self?.onUpdate?()
        }
        
        let surnameTextInput = TextInputFormField(placeholderText: "Surname")
        
        surnameTextInput.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        firstNameTextInput.onFinish = { [weak surnameTextInput] _ in
            surnameTextInput?.viewController.becomeFirstResponder()
        }
        
        fields = [firstNameTextInput, surnameTextInput]
    }
}
