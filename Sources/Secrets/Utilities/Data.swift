//
// Data.swift
//
// Created by Marcel Tesch on 2020-06-03.
// Think different.
//

import Foundation

import CryptoKit

extension Data {

    private static let binaryFileHeader = Self(count: 16)

    private enum BinaryFileError: Error {

        case nonZeroHeader

    }

    init(contentsOfBinaryFile url: URL, options: Self.ReadingOptions = []) throws {
        let result = try Self(contentsOf: url, options: options)

        guard result.prefix(Self.binaryFileHeader.count) == Self.binaryFileHeader else {
            throw BinaryFileError.nonZeroHeader
        }

        self = result.dropFirst(Self.binaryFileHeader.count)
    }

    func writeBinaryFile(to url: URL, options: Self.WritingOptions = []) throws {
        let result = Self.binaryFileHeader + self

        try result.write(to: url, options: options)
    }

}

extension Data {

    static var contentsOfStandardInput: Self? {
        let handle = FileHandle.standardInput

        guard (try? handle.seekToEnd()) == nil, let result = try? handle.readToEnd() else { return nil }

        return result
    }

}

extension Data {

    private static let salt = Self([0x6A, 0xBF, 0x22, 0xE4, 0x0D, 0x79, 0x33, 0x2E, 0xF6, 0x4D, 0x58, 0xA2, 0x5A, 0x83, 0x53, 0x33])

    private var salted: Self { self + Self.salt }

    private var hashed: Self { Self(SHA256.hash(data: self)) }

}

extension Data {

    func encrypt(using key: Self) -> Self? {
        guard let result = try? AES.GCM.seal(self, using: .init(data: key.salted.hashed)) else { return nil }

        return result.combined
    }

    func decrypt(using key: Self) -> Self? {
        return try? AES.GCM.open(.init(combined: self), using: .init(data: key.salted.hashed))
    }

}
