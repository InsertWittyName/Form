//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

class PickerInputViewController: UIViewController {
    
    @IBOutlet private var textField: UITextField! {
        didSet {
            let inputView = UIView()
            inputView.translatesAutoresizingMaskIntoConstraints = false
            inputView.backgroundColor = UIColor.gray
            inputView.heightAnchor.constraint(equalToConstant: 216).isActive = true
            textField.inputView = inputView
        }
    }
    
    let formField: PickerInputFormField
    
    init(formField: PickerInputFormField) {
        self.formField = formField
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.placeholder = formField.placeholderText
        textField.returnKeyType = formField.returnKeyType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func becomeFirstResponder() -> Bool {
        return textField.becomeFirstResponder()
    }
    
    override var canBecomeFirstResponder: Bool {
        return textField.canBecomeFirstResponder
    }
    
    override func resignFirstResponder() -> Bool {
        return textField.resignFirstResponder()
    }
    
    override var canResignFirstResponder: Bool {
        return textField.canResignFirstResponder
    }
}
