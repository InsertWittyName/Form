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
        
        let emptyTextInput3 = TextInputFormField(placeholderText: "Empty")
        
        emptyTextInput3.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        emptyTextInput3.onFinish = { [weak self] _ in
            self?.onFieldDidEndEditing?(emptyTextInput3)
        }
        
        ///
        
        let emptyTextInput4 = TextInputFormField(placeholderText: "Empty")
        
        emptyTextInput4.onChange = { [weak self] _ in
            self?.onUpdate?()
        }
        
        emptyTextInput4.onFinish = { [weak self] _ in
            self?.onFieldDidEndEditing?(emptyTextInput4)
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
        
        fields = [firstNameTextInput, surnameTextInput, emptyTextInput1, emptyTextInput2, emptyTextInput3, emptyTextInput4, pickerInput, otherTextInput]
    }
}
