//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

protocol FormField: class {
    var viewController: UIViewController { get }
    var onChange:((String) -> Void)? { get set }
    var onFinish:((String) -> Void)? { get set }
}
