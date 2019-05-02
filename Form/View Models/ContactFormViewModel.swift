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
        
        firstNameTextInput.onChange = { [weak self] value in
            guard let self = self else { return }
            firstNameTextInput.isValid = self.isValueValid(value)
            self.onUpdate?()
        }
        
        firstNameTextInput.onFinish = { [weak self] value in
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
        
        let emptyTextInput1 = TextInputFormField(placeholderText: "Empty")
        
        emptyTextInput1.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        emptyTextInput1.onFinish = { [weak self] _ in
            self?.onFieldDidEndEditing?(emptyTextInput1)
        }
        
        emptyTextInput1.inputText = "Populated text"
        
        ///
        
        let emptyTextInput2 = TextInputFormField(placeholderText: "Empty")
        
        emptyTextInput2.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        emptyTextInput2.onFinish = { [weak self] _ in
            self?.onFieldDidEndEditing?(emptyTextInput2)
        }
        
        ///
        
        let pickerInput = PickerInputFormField(placeholderText: "Picker", options: ["One", "Two", "Three", "Four", "Five"])
        
        pickerInput.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        pickerInput.onFinish = { [weak self] _ in
            self?.onFieldDidEndEditing?(pickerInput)
        }
        
        ///
        
        let otherTextInput = TextInputFormField(placeholderText: "Other field")
        otherTextInput.returnKeyType = .done
        
        otherTextInput.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        otherTextInput.onFinish = { [weak self] _ in
            self?.onFieldDidEndEditing?(otherTextInput)
        }
        
        ///
        
        let postcodeLookupField = PostcodeLookupFormField()
        
        postcodeLookupField.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        postcodeLookupField.onFinish = { [weak self] _ in
            self?.onFieldDidEndEditing?(postcodeLookupField)
        }
        
        fields = [firstNameTextInput, surnameTextInput, emptyTextInput1, emptyTextInput2, pickerInput, otherTextInput, postcodeLookupField]
    }
}

extension ContactFormViewModel {
    private func isValueValid(_ value: String) -> Bool {
        return !value.isEmpty
    }
}
