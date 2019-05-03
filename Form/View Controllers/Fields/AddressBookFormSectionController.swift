//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

class AddressBookFormSectionController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private let formField: AddressBookFormSection
    
    // MARK: - Init
    init(formField: AddressBookFormSection) {
        self.formField = formField
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewsWithData()
    }
}

// MARK: - Configure UI
extension AddressBookFormSectionController {
    private func configureViewsWithData() {
        titleLabel.text = formField.title
    }
}
