import Foundation
import Compression

// From https://github.com/mezhevikin/Zlib/blob/master/Sources/Zlib/Zlib.swift

extension Data {
    var decompressed: Data {
        let size = 8_000_000
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: size)
        defer { buffer.deallocate() }
        let result = dropFirst(2).withUnsafeBytes({
            let read = compression_decode_buffer(
                buffer,
                size,
                $0.baseAddress!.bindMemory(
                    to: UInt8.self,
                    capacity: 1
                ),
                $0.count,
                nil,
                COMPRESSION_ZLIB
            )
            return Data(bytes: buffer, count: read)
        })
        return result
    }
}
