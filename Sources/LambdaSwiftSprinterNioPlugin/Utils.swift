//    Copyright 2019 (c) Andrea Scuderi - https://github.com/swift-sprinter
//
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//
//        http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.

import Foundation
import NIO
import NIOHTTP1
import NIOFoundationCompat
import LambdaSwiftSprinter

internal extension HTTPHeaders {
    var dictionary: [String: String] {
        var headers: [String: String] = [:]
        forEach { key, value in
            headers[key] = value
        }
        return headers
    }
}

internal extension Data {

    init<T: Encodable>(from object: T) throws {
        let jsonEncoder = JSONEncoder()
        self = try jsonEncoder.encode(object)
    }
    
    func decode<T: Decodable>() throws -> T {
        let jsonDecoder = JSONDecoder()
        let input = try jsonDecoder.decode(T.self, from: self)
        return input
    }

    func jsonObject() throws -> [String: Any] {
        let jsonObject = try JSONSerialization.jsonObject(with: self)
        guard let payload = jsonObject as? [String: Any] else {
            throw SprinterError.invalidJSON
        }
        return payload
    }

    init(jsonObject: [String: Any]) throws {
        self = try JSONSerialization.data(withJSONObject: jsonObject)
    }

    var byteBuffer: ByteBuffer {
        var buffer = ByteBufferAllocator().buffer(capacity: self.count)
        buffer.writeBytes(self)
        return buffer
    }
}

internal extension HTTPResponseStatus {
    func isValid() -> Bool {
        switch self {
        case .ok,
             .created,
             .accepted,
             .nonAuthoritativeInformation,
             .noContent,
             .resetContent,
             .partialContent:
            return true
        default:
            return false
        }
    }
}
