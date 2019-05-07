//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

protocol PostcodeLookupFormFieldDelegate: class {
    func didLookupAddresses(_ addresses: [String])
}

class PostcodeLookupFormField: FormField {
    var onChange:((String) -> Void)?
    var onFinish:((String) -> Void)?
    var onSelect:((String) -> Void)?
    
    var inputPostcode: String?
    var placeholderText: String
    var addresses: [String]?
    
    var isValid: Bool = false {
        didSet {
            viewController.state = isValid ? .valid : .invalid
        }
    }
    
    weak var delegate: PostcodeLookupFormFieldDelegate?
    
    lazy var viewController: ValidatableViewController = {
        return PostcodeLookupViewController(formField: self)
    }()
    
    init(placeholderText: String) {
        self.placeholderText = placeholderText
    }
    
    func lookupAddresses(for postcode: String) {
        // Simulate a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            
            self.addresses = Array(repeating: "X The Road, Manchester", count: 12)
            
            if let addresses = self.addresses {
                self.delegate?.didLookupAddresses(addresses)
            }
        }
    }
}
