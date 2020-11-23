//
//  Array+Extension.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 22/11/2020.
//

import Foundation

public extension Array {
    
    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
