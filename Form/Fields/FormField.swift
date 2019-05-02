//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

enum ValidationState {
    case unknown
    case notRequired
    case invalid
    case valid
}

protocol Validatable {
    var state: ValidationState { get set }
}

typealias ValidatableViewController = UIViewController & Validatable

protocol FormField: class {
    var viewController: ValidatableViewController { get }
    var isValid: Bool { get set }
    
    var onChange:((String) -> Void)? { get set }
    var onFinish:((String) -> Void)? { get set }
}
