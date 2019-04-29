//
//  Copyright © 2019 DP Ltd. All rights reserved.
//

import UIKit

// MARK: - StackViewController

open class StackViewController: UIViewController {
    // MARK: Properties
    
    public let scrollView: UIScrollView
    public let stackView: UIStackView
    private var stackViewWidthConstraint: NSLayoutConstraint!
    private var scrollViewHeightConstraint: NSLayoutConstraint!
    
    public var scrollContentInset: UIEdgeInsets {
        get { return scrollView.contentInset }
        set {
            scrollView.contentInset = newValue
            stackViewWidthConstraint?.constant = -(newValue.horizontalInset)
        }
    }
    public var isScrollEnabled = true {
        didSet { didSetIsScrollEnabled() }
    }
    
    // MARK: Initialisation
    
    public init(scrollView: UIScrollView = UIScrollView(),
                stackView: UIStackView = UIStackView()) {
        self.scrollView = scrollView
        self.stackView = stackView
        
        super.init(nibName: nil, bundle: nil)
        
        setupScrollView()
        setupStackView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.scrollView = UIScrollView()
        self.stackView = UIStackView()
        
        super.init(coder: aDecoder)
        
        setupScrollView()
        setupStackView()
    }
    
    // MARK: View Controller Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        var constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ]
        
        stackViewWidthConstraint = stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -(scrollContentInset.horizontalInset))
        scrollViewHeightConstraint = scrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor)
        
        constraints.append(stackViewWidthConstraint)
        constraints.append(scrollViewHeightConstraint)
        
        NSLayoutConstraint.activate(constraints)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        didSetIsScrollEnabled()
    }
    
    // MARK: Adding
    
    public func insert(_ viewControllerToBeInserted: UIViewController, at position: Position) {
        viewControllerToBeInserted.willMove(toParent: self)
        
        addChild(viewControllerToBeInserted)
        
        let index = indexByCreatingForInsertion(from: position)
        stackView.insertArrangedSubview(viewControllerToBeInserted.view, at: index)
        
        viewControllerToBeInserted.didMove(toParent: self)
    }
    
    public func insert(_ viewToBeInserted: UIView, at position: Position) {
        let index = indexByCreatingForInsertion(from: position)
        stackView.insertArrangedSubview(viewToBeInserted, at: index)
    }
    
    public func append(_ viewControllerToBeInserted: UIViewController) {
        insert(viewControllerToBeInserted, at: .end)
    }
    
    public func append(_ viewToBeInserted: UIView) {
        insert(viewToBeInserted, at: .end)
    }
    
    // MARK: Removing
    
    public func removeAllArrangedViews() {
        children.forEach { remove($0) }
        
        // Remove any non VC views after removing child VCs. Calling this first will remove the VC views
        //      without removing them as child VCs.
        stackView.arrangedSubviews.forEach { remove($0) }
    }
    
    public func remove(_ viewControllerToBeRemoved: UIViewController) {
        guard removeViewFromStackView(viewToBeRemoved: viewControllerToBeRemoved.view) else { return }
        
        viewControllerToBeRemoved.willMove(toParent: nil)
        viewControllerToBeRemoved.removeFromParent()
        viewControllerToBeRemoved.didMove(toParent: nil)
    }
    
    public func remove(_ viewToBeRemoved: UIView) {
        removeViewFromStackView(viewToBeRemoved: viewToBeRemoved)
    }
}

// MARK: - Position

public extension StackViewController {
    enum Position {
        case start
        case end
        case index(Int)
    }
}

// MARK: - Private Helpers

private extension StackViewController {
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .white
    }
    
    func setupStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0.0
    }
    
    func indexByCreatingForInsertion(from position: Position) -> Int {
        let index: Int
        
        switch position {
        case .start:            index = 0
        case .end:              index = stackView.arrangedSubviews.count
        case .index(let int):   index = min(int, stackView.arrangedSubviews.count)
        }
        
        return index
    }
    
    @discardableResult
    func removeViewFromStackView(viewToBeRemoved: UIView) -> Bool {
        let viewWasRemoved: Bool
        
        if stackView.arrangedSubviews.contains(viewToBeRemoved) {
            stackView.removeArrangedSubview(viewToBeRemoved)
            
            // Note, view is removed from the `arrangedSubviews` array only so we need to call
            //  `removeFromSuperview()` explicitly.
            // See `removeArrangedSubview(_:)` in `UIStackView` for more details.
            viewToBeRemoved.removeFromSuperview()
            
            viewWasRemoved = true
        } else {
            viewWasRemoved = false
        }
        
        return viewWasRemoved
    }
    
    func didSetIsScrollEnabled() {
        scrollViewHeightConstraint?.isActive = !isScrollEnabled
        scrollView.isScrollEnabled = isScrollEnabled
    }
}

// MARK: - UIEdgeInsets

private extension UIEdgeInsets {
    var horizontalInset: CGFloat { return left + right }
}
