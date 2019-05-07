//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import Foundation

class ContactFormViewModel: FormViewModel {
    var sections = [FormSection]()
    var onUpdate: (() -> Void)?
    var onFieldDidEndEditing: ((FormField) -> Void)?
    
    private let searchPostcodeViewModel = PostcodeLookupFormField(placeholderText: "EC1R 5EN")
    private let countryViewModel = PickerInputFormField(placeholderText: "Country", options: ["Hmmm"])
    private let addressLineViewModel = TextInputFormField(placeholderText: "Address line")
    private let cityViewModel = TextInputFormField(placeholderText: "City")
    private let stateViewModel = TextInputFormField(placeholderText: "State")
    private let postCodeViewModel = TextInputFormField(placeholderText: "Post code")
    
    private var contactDetailsSection = AddressBookFormSection(fields: [])
    private var addressDetailsSection = AddressBookFormSection(fields: [])
    
    init() {
        configureContactDetailsViewModels()
        configureAddressDetailsViewModels()
        
        self.sections = [contactDetailsSection, addressDetailsSection]
    }
    
    private func configureContactDetailsViewModels() {
        let firstNameViewModel = TextInputFormField(placeholderText: "First name")
        firstNameViewModel.returnKeyType = .next
        firstNameViewModel.onFinish = { [weak self] value in
            self?.onFieldDidEndEditing?(firstNameViewModel)
        }
        
        let lastNameViewModel = TextInputFormField(placeholderText: "Last name")
        lastNameViewModel.returnKeyType = .next
        lastNameViewModel.onFinish = { [weak self] value in
            self?.onFieldDidEndEditing?(lastNameViewModel)
        }
        
        let companyNameViewModel = TextInputFormField(placeholderText: "Company name")
        companyNameViewModel.returnKeyType = .next
        companyNameViewModel.onFinish = { [weak self] value in
            self?.onFieldDidEndEditing?(companyNameViewModel)
        }
        
        let birthdayViewModel = PickerInputFormField(placeholderText: "Birthday", options: ["Hmmm"])
        birthdayViewModel.onFinish = { [weak self] value in
            self?.onFieldDidEndEditing?(birthdayViewModel)
        }
        
        contactDetailsSection = AddressBookFormSection(title: "Contact Details", fields: [firstNameViewModel, lastNameViewModel, companyNameViewModel, birthdayViewModel])
    }
    
    private func configureAddressDetailsViewModels() {
        searchPostcodeViewModel.onFinish = { [weak self] value in
            guard let self = self else { return }
            self.onFieldDidEndEditing?(self.searchPostcodeViewModel)
        }
        searchPostcodeViewModel.onSelect = { [weak self] value in
            self?.didSelectAddress(address: value)
        }
        
        countryViewModel.onFinish = { [weak self] value in
            guard let self = self else { return }
            self.onFieldDidEndEditing?(self.countryViewModel)
        }
        
        addressLineViewModel.returnKeyType = .next
        addressLineViewModel.onFinish = { [weak self] value in
            guard let self = self else { return }
            self.onFieldDidEndEditing?(self.addressLineViewModel)
        }
        
        cityViewModel.returnKeyType = .next
        cityViewModel.onFinish = { [weak self] value in
            guard let self = self else { return }
            self.onFieldDidEndEditing?(self.cityViewModel)
        }
        
        stateViewModel.returnKeyType = .next
        stateViewModel.onFinish = { [weak self] value in
            guard let self = self else { return }
            self.onFieldDidEndEditing?(self.stateViewModel)
        }
        
        postCodeViewModel.returnKeyType = .done
        postCodeViewModel.onFinish = { [weak self] value in
            guard let self = self else { return }
            self.onFieldDidEndEditing?(self.postCodeViewModel)
        }
        
        addressDetailsSection = AddressBookFormSection(title: "Address Details", fields: [searchPostcodeViewModel])
    }
}

extension ContactFormViewModel {
    func didSelectAddress(address: String) {
        showAllAddressDetailsFields()
        onUpdate?()
    }
    
    func showAllAddressDetailsFields() {
        addressDetailsSection.fields = [countryViewModel, addressLineViewModel, cityViewModel, stateViewModel, postCodeViewModel]
    }
}

extension ContactFormViewModel {
    private func isValueValid(_ value: String) -> Bool {
        return !value.isEmpty
    }
}
