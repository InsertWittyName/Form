//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

class TextInputViewController: UIViewController {
    
    @IBOutlet private var textField: UITextField!
    
    let formField: TextInputFormField
    
    init(formField: TextInputFormField) {
        self.formField = formField
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.placeholder = formField.placeholderText
        textField.returnKeyType = formField.returnKeyType
        textField.keyboardType = formField.keyboardType
        textField.textContentType = formField.textContentType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
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


extension TextInputViewController: UITextFieldDelegate {
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        formField.onChange?(textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        formField.inputText = textField.text
        formField.onFinish?(textField.text ?? "")
    }
}
