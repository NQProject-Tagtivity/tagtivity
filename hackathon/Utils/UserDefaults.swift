//
//  UserDefaults.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import Foundation



extension UserDefaults {
    
    enum Keys: String {
                
        case userName
        case tags
        case text
        case icon
        case id
                        
        var defaultValue: Any? {
            switch self {
                           
            case .userName: return ""
            case .tags: return ""
            case .text: return ""
            case .icon: return ""
            case .id: return 0
            }
        }
    }
    
    class var appDefaults: [String: Any] {
        
        return [UserDefaults.Keys.userName.rawValue: UserDefaults.Keys.userName.defaultValue as Any,
                UserDefaults.Keys.tags.rawValue: UserDefaults.Keys.tags.defaultValue as Any,
                UserDefaults.Keys.text.rawValue: UserDefaults.Keys.text.defaultValue as Any,
                UserDefaults.Keys.icon.rawValue: UserDefaults.Keys.icon.defaultValue as Any,
                UserDefaults.Keys.id.rawValue: UserDefaults.Keys.id.defaultValue as Any]
    }
    
    
    class var userName: String? {
        return standard.string(forKey: Keys.userName.rawValue)
    }

    class func set(userName: String) {
        standard.set(userName, forKey: Keys.userName.rawValue)
    }
    
    class var tags: String? {
        return standard.string(forKey: Keys.tags.rawValue)
    }

    class func set(tags: String) {
        standard.set(tags, forKey: Keys.tags.rawValue)
    }
    
    class var text: String? {
        return standard.string(forKey: Keys.text.rawValue)
    }

    class func set(text: String) {
        standard.set(text, forKey: Keys.text.rawValue)
    }
    
    class var icon: String? {
        return standard.string(forKey: Keys.icon.rawValue)
    }

    class func set(icon: String) {
        standard.set(icon, forKey: Keys.icon.rawValue)
    }
    
    class var id: Int {
        return standard.integer(forKey: Keys.id.rawValue)
    }

    class func set(id: Int) {
        standard.set(id, forKey: Keys.id.rawValue)
    }
}
