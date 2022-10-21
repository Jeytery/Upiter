import Foundation

public protocol Archivable {
    func archive() -> Data?
    static func unarchive(data: Data) -> Self?
}

extension Archivable where Self: Codable {
    func archive() -> Data? {
        guard let json = try? JSONEncoder().encode(self) else { return nil }
        return Data(json)
    }
    
    static func unarchive(data: Data) -> Self? {
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}

public protocol Jsonable {
    var json: String { get }
}

extension Jsonable where Self: Encodable {
    var json: String {
        let jsonData = try! JSONEncoder().encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}

public protocol Dictionarable {
    var dictionary: [String: Any]? { get }
}

extension Dictionarable where Self: Encodable {
    var dictionary: [String: Any]? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
            return nil
        }
        return dict as? [String: Any]
    }
}

extension Array where Element: Codable {
    func archive() -> Data? {
        guard let json = try? JSONEncoder().encode(self) else { return nil }
        return Data(json)
    }
    
    static func unarchive(data: Data) -> Self? {
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}
