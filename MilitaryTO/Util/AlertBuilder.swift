//
//  AlertBuilder.swift
//  MilitaryTO
//
//  Created by 장혜준 on 13/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class AlertBuilder {
    private(set) var controller: UIAlertController!
    private(set) var textFields: [UITextField] = []
    
    init(title: String?, message: String) {
        controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.view.tintColor = .red
    }
    
    convenience init(title: String?, message: String, cancellable: Bool, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        self.init(title: title, message: message)
        if cancellable {
            _ = addCancel(cancelHandler)
        }
    }
    
    @discardableResult
    func addAction(_ action: UIAlertAction) -> Self {
        controller.addAction(action)
        return self
    }
    
    @discardableResult
    func addTextField(handler: ((UITextField) -> Void)?) -> Self {
        controller.addTextField {
            self.textFields.append($0)
            handler?($0)
        }
        return self
    }
    
    @discardableResult
    func addAction(title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        return addAction(UIAlertAction(title: title, style: style, handler: handler))
    }
    
    @discardableResult
    func addAction(title: String?, style: UIAlertAction.Style, handler: (() -> Void)?) -> Self {
        if let handler = handler {
            return addAction(UIAlertAction(title: title, style: style) { _ in handler() })
        }
        return addAction(UIAlertAction(title: title, style: style, handler: nil))
    }
    
    @discardableResult
    func addDefault(title: String?, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        return addAction(title: title, style: .default, handler: handler)
    }
    
    @discardableResult
    func addDefault(title: String?, handler: (() -> Void)?) -> Self {
        return addAction(title: title, style: .default, handler: handler)
    }
    
    @discardableResult
    func addDestructive(title: String?, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        return addAction(title: title, style: .destructive, handler: handler)
    }
    
    @discardableResult
    func addDestructive(title: String?, handler: (() -> Void)?) -> Self {
        return addAction(title: title, style: .destructive, handler: handler)
    }
    
    @discardableResult
    func addCancel(title: String, handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        return addAction(title: title, style: .cancel, handler: handler)
    }
    
    @discardableResult
    func addCancel(title: String, handler: (() -> Void)?) -> Self {
        return addAction(title: title, style: .cancel, handler: handler)
    }
    
    @discardableResult
    func addOk(_ handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        return addDefault(title: "확인", handler: handler)
    }
    
    @discardableResult
    func addOk(_ handler: (() -> Void)?) -> Self {
        return addDefault(title: "확인", handler: handler)
    }
    
    @discardableResult
    func addCancel(_ handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        return addCancel(title: "취소", handler: handler)
    }
    
    @discardableResult
    func addCancel(_ handler: (() -> Void)?) -> Self {
        return addCancel(title: "취소", handler: handler)
    }
    
    @discardableResult
    func addDontShowAgain(_ handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        return addDestructive(title: "다시 보지 않기", handler: handler)
    }
    
    @discardableResult
    func addDontShowAgain(_ handler: (() -> Void)?) -> Self {
        return addDestructive(title: "다시 보지 않기", handler: handler)
    }
    
    @discardableResult
    func present(parent: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) -> Self {
        parent.present(builder: self, animated: animated, completion: completion)
        return self
    }
}
