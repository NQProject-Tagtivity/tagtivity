//
//  UIImageView+Extension.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import Foundation
import UIKit

extension UIImageView {

    var imageColor: UIColor? {
        set (newValue) {
            guard let image = image else { return }
            if newValue != nil {
                self.image = image.withRenderingMode(.alwaysTemplate)
                tintColor = newValue
            } else {
                self.image = image.withRenderingMode(.alwaysOriginal)
                tintColor = UIColor.clear
            }
        }
        get { return tintColor }
    }

    func setImageWithAnimation(_ image: UIImage?) {
        
        UIView.transition(with: self,
                          duration: 0.2,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.image = image
            }, completion: nil)
    }
}
