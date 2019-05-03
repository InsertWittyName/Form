//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

protocol FormSection: class {
    var fields: [FormField] { get set }
    var title: String? { get set }
    var viewController: UIViewController { get }
}
