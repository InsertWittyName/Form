//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import Foundation

protocol FormViewModel {
    var sections: [FormSection] { get set }
    var onUpdate: (() -> Void)? { get set }
    var onFieldDidEndEditing: ((FormField) -> Void)? { get set }
}
