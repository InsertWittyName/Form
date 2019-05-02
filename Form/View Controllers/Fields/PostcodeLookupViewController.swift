//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

class PostcodeLookupViewController: ValidatableViewController {
    var state: ValidationState = .unknown {
        didSet {
            switch state {
            case .notRequired:
                break
            case .invalid:
                view.backgroundColor = UIColor.red
            case .valid, .unknown:
                view.backgroundColor = UIColor.white
            }
        }
    }
    
    
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var addressesTableView: UITableView! {
        didSet {
            addressesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        }
    }
    
    let formField: PostcodeLookupFormField
    
    init(formField: PostcodeLookupFormField) {
        self.formField = formField
        
        super.init(nibName: nil, bundle: nil)
        
        self.formField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = formField.inputPostcode
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
    
    @IBAction private func didSelectFindAddressButton(_ findAddressButton: UIButton) {
        guard let postcode = textField.text, postcode.isEmpty == false else { return }
        
        view.endEditing(true)
        
        formField.lookupAddresses(for: postcode)
    }
}

extension PostcodeLookupViewController: UITextFieldDelegate {
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        formField.onChange?(textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        formField.inputPostcode = textField.text
        formField.onFinish?(textField.text ?? "")
    }
}

extension PostcodeLookupViewController: PostcodeLookupFormFieldDelegate {
    func didLookupAddresses(_ addresses: [String]) {
        
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.addressesTableView.isHidden = addresses.isEmpty
        })
        
        addressesTableView.reloadData()
    }
}

extension PostcodeLookupViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return formField.addresses?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = formField.addresses![indexPath.row]
        
        return cell
    }
}

extension PostcodeLookupViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let address = formField.addresses![indexPath.row]
        formField.onFinish?(address)
    }
}
