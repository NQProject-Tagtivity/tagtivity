//
//  ApiModel.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import Foundation

class User: Codable {
    
    var id: Int
    var username: String
    var icon: String
    var description: String
    var tags: [String]
    
    init(id: Int, username: String, icon: String, description: String, tags: [String]) {
        self.id = id
        self.username = username
        self.icon = icon
        self.description = description
        self.tags = tags
    }
}

class CreateEventModel: Codable {
    
    var host: UInt64
    var startTime: UInt64
    var endTime: UInt64
    var title: String
    var description: String
    var maxMembers: Int
    var icon: String
    var tags: [String]
    
    init(host: UInt64, startTime: UInt64, endTime: UInt64, title: String, description: String, maxMembers: Int, icon: String, tags: [String]) {
        self.host = host
        self.startTime = startTime
        self.endTime = endTime
        self.description = description
        self.title = title
        self.maxMembers = maxMembers
        self.icon = icon
        self.tags = tags
    }
}

class EventUserModel: Codable {
    var username: String
    var icon: String
    
    init(username: String, icon: String) {
        self.username = username
        self.icon = icon
    }
}

class EventModel: Codable {
    
    var id: UInt64
    var host: EventUserModel
    var startTime: UInt64
    var endTime: UInt64
    var title: String
    var description: String
    var maxMembers: Int
    var icon: String
    var tags: [String]
    var members: [EventUserModel]
    
    init(id: UInt64, host: EventUserModel, startTime: UInt64, endTime: UInt64, title: String, description: String, maxMembers: Int, icon: String, tags: [String], members: [EventUserModel]) {
        self.id = id
        self.host = host
        self.startTime = startTime
        self.endTime = endTime
        self.title = title
        self.description = description
        self.maxMembers = maxMembers
        self.icon = icon
        self.tags = tags
        self.members = members
    }
}

class GetEventsModel: Codable {
    var events: [EventModel]
    
    init(events: [EventModel]) {
        self.events = events
    }
}

class AddMemberModel: Codable {
    
    var userId: UInt64
    
    init(userId: UInt64) {
        self.userId = userId
    }
}
