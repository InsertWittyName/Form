//  Copyright © 2018 moonpig.com. All rights reserved.

import UIKit

extension UIScrollView {
    
    // MARK: - Public
    
    public func viewportRectContains(_ view: UIView) -> Bool {
        guard view.isDescendant(of: self) else {
            return false
        }
        var viewportRect = bounds
        viewportRect.origin.y += contentInset.top
        viewportRect.size.height -= contentInset.top + contentInset.bottom
        viewportRect.origin.x += contentInset.left
        viewportRect.size.width -= contentInset.left + contentInset.right
        return viewportRect.intersects(view.frame)
    }
    
    public func startObservingKeyboard() {
        originalContentInset = contentInset
        addDismissKeyboardGesture()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // MARK: - Private
    
    private func addDismissKeyboardGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    private func stopTrackingKeyboard() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    private var originalContentInset: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedValue.originalContentInsetKey) as? UIEdgeInsets
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedValue.originalContentInsetKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private struct AssociatedValue {
        static var originalContentInsetKey = 0
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let keyboardViewFrame = convert(keyboardScreenEndFrame, from: window)
        notification.name == UIResponder.keyboardWillHideNotification ? keyboardWillHide(keyboardViewFrame) : keyboardWillShow(keyboardViewFrame)
    }
    
    private func keyboardWillHide(_ keyboardViewFrame: CGRect) {
        contentInset = originalContentInset ?? .zero
    }
    
    private func keyboardWillShow(_ keyboardViewFrame: CGRect) {
        contentInset.bottom = keyboardViewFrame.height
        let visibleScrollableArea = frame.height - contentInset.top - keyboardViewFrame.height
        
        if let firstResponder = window?.firstResponder,
            visibleScrollableArea < firstResponder.frame.maxY {
            contentOffset.y = (firstResponder.frame.maxY - visibleScrollableArea)
        }
    }
}


public extension UIView {
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        
        return nil
    }
}
