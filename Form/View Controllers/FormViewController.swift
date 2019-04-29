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
