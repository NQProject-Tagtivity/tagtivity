//
//  Api.swift
//  hackathon
//
//  Created by Szymon Gęsicki on 21/11/2020.
//

import Foundation
import Moya

//-- Endpoints ----------------------------------------

enum AppApi {

    case signIn(username: String)
    case updateUser(user: User)
    case createEvent(event: CreateEventModel)
    case getEvents
    case searchEvents(tags: String)
    case addMember(eventId: UInt64, userId: UInt64)
    case removeMember(eventId: UInt64, userId: UInt64)
}

let endpointClosure = { (target: AppApi) -> Endpoint in
    
    let url = URL(target: target).absoluteString

    return Endpoint(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
}

private var defaultError: Moya.MoyaError = {
    
    Moya.MoyaError.underlying(NSError(domain: NSURLErrorDomain, code: NSURLErrorUnknown, userInfo: nil), nil)
}()


private var lastTimeErrorDate: Date?

func defaultRequest( api: AppApi, progress: ProgressBlock?, completion: @escaping Completion ) -> Cancellable? {
    

    let defaultAPIProvider = MoyaProvider<AppApi>(endpointClosure: endpointClosure, plugins: [CompleteUrlLoggerPlugin()])
    
    
    return defaultAPIProvider.request(api, callbackQueue: DispatchQueue.main, progress: progress, completion: { result in
        
        if case .success(_) = result {
            lastTimeErrorDate = nil
            
        } else if case let .failure(error) = result {
            
            switch error {
            case .underlying(let nsError as NSError, _):
                
                if nsError.code == -999 {
                    return
                }
            default:
                break
            }
            
            if error._code == NSURLErrorCannotFindHost {
                print("could_not_connect_to_remote")
            } else {
                
                if lastTimeErrorDate == nil || Date().timeIntervalSinceReferenceDate - (lastTimeErrorDate?.timeIntervalSinceReferenceDate ?? 0) > 60 * 1000 {
                    lastTimeErrorDate = Date()
                    print(error.localizedDescription)
                }
            }
        }
        
        completion( result )
    })
}

func defaultRequest( api: AppApi, completion: @escaping Completion ) -> Cancellable? {
    
    return defaultRequest( api: api, progress: nil, completion: completion )
}

extension AppApi: TargetType {
    
    var baseURL: URL {
        return URL(string: Config.APIBaseURL)!
    }
    
    var path: String {
        
        switch self {
        case .signIn(let username):
            return "users/\(username)"
        case .updateUser(let user):
            return "users/\(user.id)"
        case .createEvent:
            return "events"
        case .getEvents:
            return "events"
        case .addMember(let eventId, _):
            return "events/\(eventId)/members"
        case .removeMember(let eventId, let userId):
            return "events/\(eventId)/members/\(userId)"
        case .searchEvents:
            return "events/search"
        }
    }
    
    var authenticationRequired: Bool {

        switch self {
        case .signIn, .updateUser, .createEvent, .getEvents, .addMember, .removeMember, .searchEvents:
            return false
        }
    }

    var headers: [String: String]? {

        switch self {
        case .signIn, .updateUser, .createEvent, .getEvents, .addMember, .removeMember, .searchEvents:
            return nil
        }
    }
    
    var sampleData: Data {
        
        switch self {
            
        default: return Data()
        }
    }
    
    var method: Moya.Method {
        
        switch self {
        case .signIn:
            return .get
        case .updateUser:
            return .put
        case .createEvent:
            return .post
        case .getEvents:
            return .get
        case .addMember:
            return .post
        case .removeMember:
            return .delete
        case .searchEvents:
            return .get
        }
    }
   
    var task: Task {
        
        switch self {
        case .signIn, .getEvents:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .updateUser(let user):
            return .requestJSONEncodable(user)
        case .createEvent(let event):
            return .requestJSONEncodable(event)
        case .addMember( _, let userId):
            return .requestJSONEncodable(AddMemberModel(userId: userId))
        case .removeMember:
            return .requestParameters(parameters: [:], encoding: URLEncoding.default)
        case .searchEvents(let tags):
            return .requestParameters(parameters: ["tags": tags], encoding: URLEncoding.default)
        }
    }
}

class CompleteUrlLoggerPlugin : PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        // uncoment if you woudl like to check url
//        print(request.request?.url?.absoluteString ?? "Something is wrong")
    }
}
