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
        
        self.formViewModel.onUpdate = {
            print("Did update")
        }
        
        super.init(nibName: nil, bundle: nil)
        
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
        
        formViewModel.fields.forEach { (field) in
            stackViewController.insert(field.viewController, at: .end)
        }
    }
}

private extension FormViewController {
    
    func setupFieldNavigation() {
        formViewModel.onFieldFinish = { [weak self] field in
            guard let self = self else { return }
            
            if let fieldIndex = self.formViewModel.fields.firstIndex(where: { $0 === field } ) {
                let nextFieldIndex = fieldIndex + 1
                
                if self.formViewModel.fields.indices.contains(nextFieldIndex) {
                    let nextField = self.formViewModel.fields[nextFieldIndex]
                    nextField.viewController.becomeFirstResponder()
                }
            }
        }
    }
}
