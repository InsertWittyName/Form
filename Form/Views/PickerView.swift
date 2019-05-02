//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

typealias PickerOption = String

class PickerView: UIView {
    @IBOutlet private weak var picker: UIPickerView!
    
    var options = [PickerOption]()
    var onSelection:((PickerOption) -> Void)?
    
    @IBAction private func didSelectDoneButton(_ doneButton: UIButton) {
        let selectedOption = options[picker.selectedRow(inComponent: 0)]
        onSelection?(selectedOption)
    }
}

extension PickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
}

extension PickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
}
