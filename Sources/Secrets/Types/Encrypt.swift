//
// Encrypt.swift
//
// Created by Marcel Tesch on 2020-06-03.
// Think different.
//

import Foundation

import ArgumentParser

struct Encrypt: SecretCommand {

    static let configuration = CommandConfiguration(abstract: "Encryption of arbitrary data.")

    @OptionGroup()
    var options: Options

}

extension Encrypt {

    static func loadFileInput(at url: URL) -> Data? {
        return try? .init(contentsOf: url)
    }

    static func loadStandardInput() -> Data? {
        return .contentsOfStandardInput
    }

    static func computeSecret(key: Data, input: Data) -> Data? {
        return input.encrypt(using: key)
    }

    static func writeToFile(data: Data, at url: URL) throws {
        try data.writeBinaryFile(to: url)
    }

    static func contentForStandardOutput(data: Data) -> Data {
        return data.base64EncodedData(options: [.lineLength64Characters])
    }

}
