//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    var formViewModel: FormViewModel
    let stackViewController: StackViewController
    
    init(formViewModel: FormViewModel) {
        self.formViewModel = formViewModel
        self.stackViewController = StackViewController()
        super.init(nibName: nil, bundle: nil)
        self.formViewModel.onUpdate = updateFormViewModel
        setupFieldNavigation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(stackViewController)
        stackViewController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewController.view)
        stackViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stackViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        addStackViewSubviews()
    }
    
    private func addStackViewSubviews() {
        formViewModel.sections.forEach { (section) in
            stackViewController.insert(section.viewController, at: .end)
            
            section.fields.forEach { (field) in
                stackViewController.insert(field.viewController, at: .end)
            }
        }
    }
    
    private func updateFormViewModel() {
        stackViewController.removeAllArrangedViews()
        addStackViewSubviews()
    }
}

private extension FormViewController {
    
    func setupFieldNavigation() {
        formViewModel.onFieldDidEndEditing = { [weak self] field in
            guard let self = self else { return }
            
            self.formViewModel.sections.forEach { (section) in
                if let fieldIndex = section.fields.firstIndex(where: { $0 === field } ) {
                    let nextFieldIndex = fieldIndex + 1
                    
                    if section.fields.indices.contains(nextFieldIndex) {
                        let nextField = section.fields[nextFieldIndex]
                        nextField.viewController.becomeFirstResponder()
                        return
                    }
                }
            }
        }
    }
}
