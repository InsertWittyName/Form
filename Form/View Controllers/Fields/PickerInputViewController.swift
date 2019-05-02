//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

class PickerInputViewController: ValidatableViewController {
    
    var state: ValidationState = .unknown {
        didSet {
            switch state {
            case .notRequired:
                break
            case .invalid:
                textField.textColor = UIColor.red
            case .valid, .unknown:
                textField.textColor = UIColor.black
            }
        }
    }
    
    @IBOutlet private var textField: UITextField! {
        didSet {
            let pickerView = Bundle.main.loadNibNamed("PickerView", owner: nil, options: nil)?.first as! PickerView
            pickerView.translatesAutoresizingMaskIntoConstraints = false
            
            pickerView.onSelection = { [weak self] selectedOption in
                self?.textField.text = selectedOption
                self?.formField.onChange?(selectedOption)
                self?.formField.onFinish?(selectedOption)
            }
            
            pickerView.options = formField.options
            
            textField.inputView = pickerView
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
