import Foundation

public protocol Archivable {
    func archive() -> Data?
    static func unarchive(data: Data) -> Self?
}

public extension Archivable where Self: Codable {
    public func archive() -> Data? {
        guard let json = try? JSONEncoder().encode(self) else { return nil }
        return Data(json)
    }
    
    public static func unarchive(data: Data) -> Self? {
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}

public protocol Jsonable {
    var json: String { get }
}

public extension Jsonable where Self: Encodable {
    public var json: String {
        let jsonData = try! JSONEncoder().encode(self)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        return jsonString
    }
}

public protocol Dictionarable {
    public var dictionary: [String: Any]? { get }
}

public extension Dictionarable where Self: Encodable {
    public var dictionary: [String: Any]? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
            return nil
        }
        return dict as? [String: Any]
    }
}

public extension Array where Element: Codable {
    public func archive() -> Data? {
        guard let json = try? JSONEncoder().encode(self) else { return nil }
        return Data(json)
    }
    
    public static func unarchive(data: Data) -> Self? {
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}
