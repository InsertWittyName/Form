//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import Foundation

class ContactFormViewModel: FormViewModel {
    var fields = [FormField]()
    var onUpdate: (() -> Void)?
    var onFieldDidEndEditing: ((FormField) -> Void)?
    
    init() {
        let firstNameTextInput = TextInputFormField(placeholderText: "First name")
        
        firstNameTextInput.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        firstNameTextInput.onFinish = { [weak self] _ in
            self?.onFieldDidEndEditing?(firstNameTextInput)
        }
        
        ///
        
        let surnameTextInput = TextInputFormField(placeholderText: "Surname")
        
        surnameTextInput.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        surnameTextInput.onFinish = { [weak self] _ in
            self?.onFieldDidEndEditing?(surnameTextInput)
        }
        
        ///
        
        let pickerInput = PickerInputFormField(placeholderText: "Picker")
        
        pickerInput.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        pickerInput.onFinish = { [weak self] _ in
            self?.onFieldDidEndEditing?(pickerInput)
        }
        
        ///
        
        let otherTextInput = TextInputFormField(placeholderText: "Other field")
        
        otherTextInput.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        otherTextInput.onFinish = { [weak self] _ in
            self?.onFieldDidEndEditing?(otherTextInput)
        }
        
        fields = [firstNameTextInput, surnameTextInput, pickerInput, otherTextInput]
    }
}
