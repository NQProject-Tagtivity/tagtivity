//
//  Mock.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 22/11/2020.
//

import Foundation

class Mock {
    
    static var shared: Mock = Mock()
    
    lazy var events: [EventModel] = self.generateEvents()
    
    func signIn(username: String) -> User {
        UserDefaults.set(id: 0)
        return User(id: 0, username: username, icon: "user2", description: "Fanatyk dobrej muzyki i sportu.", tags: ["muzyka", "sport", "pg"])
    }
    
    func createEvent(event: CreateEventModel) -> Bool {
        events.append(EventModel(id: UInt64(events.count), host: EventUserModel(username: UserDefaults.userName ?? "", icon: "user2"), startTime: event.startTime, endTime: event.endTime, title: event.title, description: event.description, maxMembers: event.maxMembers, icon: event.icon, tags: event.tags, members: [EventUserModel(username: UserDefaults.userName ?? "", icon: "user2")]))
        return true
    }
    
    func getEvents() -> GetEventsModel {
        return GetEventsModel(events: events)
    }
    
    func searchEvents(tags: String) -> GetEventsModel {
        return GetEventsModel(events: fetchEventsByTag(tags: tags))
    }

    func addMember(eventId: UInt64, userId: UInt64) -> Bool {
        events[safe: Int(eventId)]?.members.append(EventUserModel(username: UserDefaults.userName ?? "", icon: "user3"))
        return true
    }
    
    // todo
    func removeMember(eventId: UInt64, userId: UInt64) -> Bool {
        return true
    }
    
    func fetchEventsByTag(tags: String) -> [EventModel] {
        
        let tagsArray = tags.replacingOccurrences(of: "#", with: "").components(separatedBy: " ")

        var out: [(event: EventModel, count: Int)] = []

        for event in events {
            var count = 0
            for tag in tagsArray {
                if event.tags.contains(tag) {
                    count += 1
                }
            }
            
            out.append((event: event, count: count))
        }

        out.sort { $0.count > $1.count }

        return out.map { EventModel(id: $0.event.id, host: $0.event.host, startTime: $0.event.startTime, endTime: $0.event.endTime, title: $0.event.title, description: $0.event.description, maxMembers: $0.event.maxMembers, icon: $0.event.icon, tags: $0.event.tags, members: $0.event.members) }
    }
    
    func generateEvents() -> [EventModel] {
        
        let user1 = EventUserModel(username: "Marek", icon: "user3")
        let user2 = EventUserModel(username: "Krzysiek", icon: "user1")
        let user3 = EventUserModel(username: "Marta", icon: "user2")
        let user4 = EventUserModel(username: "Beata", icon: "user1")
        
        
        let event1 = EventModel(id: 0, host: user1, startTime: 1606222800, endTime: 1606222800, title: "Sheep Your Hack 2", description: "Sheep Your Hack to 24-godzinny maraton programowania, celem jest stworzenie aplikacji biznesowej. Technologia wykonania prototypu jest dowolna, sam udział w Hackathonie jest dobrowolny oraz bezpłatny. Projekt tworzony jest od zera w dniu hackathonu.", maxMembers: 10, icon: "activity9", tags: ["hackaton", "programowanie", "startup", "biznes"], members: [user1, user2])
        
        let event2 = EventModel(id: 1, host: user2, startTime: 1606242800, endTime: 1606222800, title: "Let's speak English together - rozmówki", description: "Co tydzień spotykamy się na naszym serwerze na Discordzie, by razem doskonalić swój język :)", maxMembers: 5, icon: "activity8", tags: ["angielski", "jezykiobce", "rozmowki"], members: [user2, user3])
        
        let event3 = EventModel(id: 2, host: user3, startTime: 1606322800, endTime: 1606222800, title: "Nauka Javy dla początkujących", description: "Nieważne czy jesteś studentem, uczniem szkoły średniej czy po prostu jesteś ciekawy programowania - zapraszamy na pierwszy wykład z języka Java, prowadzony przez naszego wykładowcę.", maxMembers: 5, icon: "activity1", tags: ["java", "programowanie", "politechnikagdanska", "pg", "informatyka"], members: [user3, user4])
        
        let event4 = EventModel(id: 3, host: user4, startTime: 1606322900, endTime: 1606222800, title: "Medytacja dla początkujących", description: "Sprawdź, jakie fale generuje Twój mózg w czasie medytacji. Dowiedz się, jaka medytacja jest dla Ciebie najlepsza i naucz się jej pod okiem ekspertki.", maxMembers: 5, icon: "activity1", tags: ["joga", "mindfulness", "relaks", "fitness"], members: [user1, user4])
        
        return [event1, event2, event3, event4]
    }
}
