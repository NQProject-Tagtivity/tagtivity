//
//  NetworkRequests.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import Foundation


class NetworkRequests {
    
    static var shared: NetworkRequests = NetworkRequests()
    
    func signIn(username: String, completion: @escaping((User?) -> Void)) {
        
        completion(Mock.shared.signIn(username: username))
        return
                
//        _ = defaultRequest(api: .signIn(username: username)) { result in
//
//            if case let .success(response) = result {
//
//                if 200 ... 299 ~= response.statusCode {
//
//                    do {
//
//                        let user = try JSONDecoder().decode(User.self, from: response.data)
//                        UserDefaults.set(id: user.id)
//
//                        completion(user)
//
//                    } catch let error {
//                        print("error while decoding \(error.localizedDescription)")
//                        completion(Mock.shared.signIn(username: username))
//                    }
//                } else {
//                    print("error while sign in")
//                    completion(Mock.shared.signIn(username: username))
//                }
//
//            } else if case let .failure(error) = result {
//                print("error \(error.localizedDescription)")
//                completion(Mock.shared.signIn(username: username))
//            }
//        }
    }
    
    
    func updateUser(user: User, completion: @escaping((Bool) -> Void)) {
        
        completion(true)
        return
                
//        _ = defaultRequest(api: .updateUser(user: user)) { result in
//
//
//            if case let .success(response) = result {
//
//                if 200 ... 299 ~= response.statusCode {
//                    completion(true)
//
//                } else {
//                    completion(false)
//                   print("error while")
//                }
//
//            } else if case let .failure(error) = result {
//                print("error \(error.localizedDescription)")
//                completion(false)
//            }
//        }
    }
    
    func createEvent(event: CreateEventModel, completion: @escaping((Bool) -> Void)) {
        
        completion(Mock.shared.createEvent(event: event))
        return
                
//        _ = defaultRequest(api: .createEvent(event: event)) { result in
//
//            if case let .success(response) = result {
//
//                if 200 ... 299 ~= response.statusCode {
//                    completion(true)
//
//                } else {
//                    print("error while create event")
//                    completion(Mock.shared.createEvent(event: event))
//                }
//
//            } else if case let .failure(error) = result {
//                print("error \(error.localizedDescription)")
//                completion(Mock.shared.createEvent(event: event))
//            }
//        }
    }
    
    
    func getEvents(completion: @escaping((GetEventsModel?) -> Void)) {
        
        completion(Mock.shared.getEvents())
        return
                
//        _ = defaultRequest(api: .getEvents) { result in
//
//
//            if case let .success(response) = result {
//
//                if 200 ... 299 ~= response.statusCode {
//
//                    do {
//
//                        let events = try JSONDecoder().decode(GetEventsModel.self, from: response.data)
//                        completion(events)
//
//                    } catch let error {
//                        print("error while decoding \(error.localizedDescription)")
//                        completion(Mock.shared.getEvents())
//                    }
//
//                } else {
//                    print("error while get event")
//                    completion(Mock.shared.getEvents())
//                }
//
//            } else if case let .failure(error) = result {
//                print("error \(error.localizedDescription)")
//                completion(Mock.shared.getEvents())
//            }
//        }
        
    }
    
    func searchEvents(tags: String, completion: @escaping((GetEventsModel?) -> Void)) {
        
        completion(Mock.shared.searchEvents(tags: tags))
        return
                
//        _ = defaultRequest(api: .searchEvents(tags: tags)) { result in
//
//
//            if case let .success(response) = result {
//
//                if 200 ... 299 ~= response.statusCode {
//
//                    do {
//                        let events = try JSONDecoder().decode(GetEventsModel.self, from: response.data)
//                        completion(events)
//
//                    } catch let error {
//                        print("error while decoding \(error.localizedDescription)")
//                        completion(Mock.shared.searchEvents(tags: tags))
//                    }
//
//                } else {
//                    print("error while search events code: \(response.statusCode)")
//                    completion(Mock.shared.searchEvents(tags: tags))
//                }
//
//            } else if case let .failure(error) = result {
//                print("error \(error.localizedDescription)")
//                completion(Mock.shared.searchEvents(tags: tags))
//
//            }
//        }
    }
    
    func addMember(eventId: UInt64, userId: UInt64, completion: @escaping((Bool) -> Void)) {
        
        completion(Mock.shared.addMember(eventId: eventId, userId: userId))
        return
                
//        _ = defaultRequest(api: .addMember(eventId: eventId, userId: userId)) { result in
//
//
//            if case let .success(response) = result {
//
//                if 200 ... 299 ~= response.statusCode {
//                    completion(true)
//                    return
//
//                } else {
//                    print("error while add member")
//                    completion(Mock.shared.addMember(eventId: eventId, userId: userId))
//                }
//
//            } else if case let .failure(error) = result {
//                print("error \(error.localizedDescription)")
//                completion(Mock.shared.addMember(eventId: eventId, userId: userId))
//            }
//        }
    }
    
    func removeMember(eventId: UInt64, userId: UInt64, completion: @escaping((Bool) -> Void)) {
        
        completion(Mock.shared.removeMember(eventId: eventId, userId: userId))
        return
                
//        _ = defaultRequest(api: .removeMember(eventId: eventId, userId: userId)) { result in
//
//
//            if case let .success(response) = result {
//
//                if 200 ... 299 ~= response.statusCode {
//                    completion(true)
//
//                } else {
//                    print("error while remove member")
//                    completion(Mock.shared.removeMember(eventId: eventId, userId: userId))
//                }
//
//            } else if case let .failure(error) = result {
//                print("error \(error.localizedDescription)")
//                completion(Mock.shared.removeMember(eventId: eventId, userId: userId))
//            }
//        }
    }
}
