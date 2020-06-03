//
// Decrypt.swift
//
// Created by Marcel Tesch on 2020-06-03.
// Think different.
//

import Foundation

import ArgumentParser

struct Decrypt: SecretCommand {

    static let configuration = CommandConfiguration(abstract: "Decryption of arbitrary data.")

    @OptionGroup()
    var options: Options

}

extension Decrypt {

    static func loadFileInput(at url: URL) -> Data? {
        return try? .init(contentsOfBinaryFile: url)
    }

    static func loadStandardInput() -> Data? {
        guard let result = Data.contentsOfStandardInput else { return nil }

        return Data(base64Encoded: result, options: [.ignoreUnknownCharacters])
    }

    static func computeSecret(key: Data, input: Data) -> Data? {
        return input.decrypt(using: key)
    }

    static func writeToFile(data: Data, at url: URL) throws {
        try data.write(to: url)
    }

    static func contentForStandardOutput(data: Data) -> Data {
        return data
    }

}
