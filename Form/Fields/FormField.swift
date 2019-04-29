//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

protocol FormField {
    var viewController: UIViewController { get }
    var onChange:((String) -> Void)? { get set }
    var onFinish:((String) -> Void)? { get set }
    
    var nextField: FormField? { get set }
}

//protocol FormFieldViewControllerInterface {
//    var viewModel: FormFieldViewModel { get }
//    init(viewModel: FormFieldViewModel)
//}
//
//typealias FormFieldViewController = UIViewController & FormFieldViewControllerInterface
//
//protocol FormFieldViewModel {
//    var onChange:((String) -> Void)? { get set }
//}
