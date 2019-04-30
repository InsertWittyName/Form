//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import Foundation

protocol FormViewModel {
    var fields: [FormField] { get set }
    var onUpdate: (() -> Void)? { get set }
    var onFieldFinish: ((FormField) -> Void)? { get set }
}
