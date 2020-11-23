//
//  Alert.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import Foundation
import UIKit

class Alert {
    
    @discardableResult
    static func error( _ viewController: UIViewController? = nil ) -> UIAlertController {
        
        return basic(viewController, title: "Error", message: "Something went wrong ...")
    }
    
    @discardableResult
    static func basic( _ viewController: UIViewController?, title: String?, message: String?, buttonName: String = "Ok", dismissHandler: ((UIAlertAction) -> Void)? = nil ) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: buttonName, style: .default, handler: dismissHandler )
        alertController.addAction( actionOk )
        viewController?.present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    @discardableResult
    static func basic( _ viewController: UIViewController, title: String, message: String?, dismissHandler: ((UIAlertAction) -> Void)? = nil ) -> UIAlertController {
        
        return basic( viewController, title: title, message: message, buttonName: "Ok", dismissHandler: dismissHandler )
    }
    
    @discardableResult
    static func attributed( _ viewController: UIViewController, attributedTitle: NSAttributedString, attributedMessage: NSAttributedString, buttonName: String = "Ok", dismissHandler: ((UIAlertAction) -> Void)? = nil ) -> UIAlertController {
        
        let alertController = UIAlertController(title: "", message: "", preferredStyle: .alert)
        
        alertController.setValue(attributedTitle, forKey: "attributedTitle")
        alertController.setValue(attributedMessage, forKey: "attributedMessage")
        let actionOk = UIAlertAction(title: buttonName, style: .default, handler: dismissHandler )
        
        alertController.addAction( actionOk )
        viewController.present(alertController, animated: true, completion: nil)
        
        return alertController
    }
    
    static func withSecondButton( _ viewController: UIViewController, title: String, message: String?, firstButtonHandler: ((UIAlertAction) -> Void)? = nil, secondButtonTitle: String, secondButtonHandler: @escaping ((UIAlertAction) -> Void)  ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionFirst = UIAlertAction(title: "Ok", style: .default, handler: firstButtonHandler )
        alertController.addAction( actionFirst )
        
        let actionSecond = UIAlertAction(title: secondButtonTitle, style: .default, handler: secondButtonHandler )
        alertController.addAction( actionSecond )
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    static func yesNo( _ viewController: UIViewController, title: String, message: String?, yesHandler: @escaping ((UIAlertAction) -> Void), noHandler: @escaping ((UIAlertAction) -> Void) ) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let actionYes = UIAlertAction(title: "yes", style: .destructive, handler: yesHandler )
        alertController.addAction( actionYes )
        
        let actionNo = UIAlertAction(title: "cancel", style: .cancel, handler: noHandler )
        alertController.addAction( actionNo )

        viewController.present(alertController, animated: true, completion: nil)
    }
}
