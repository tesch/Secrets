//
// SecretDelegate.swift
//
// Created by Marcel Tesch on 2020-06-03.
// Think different.
//

import Foundation

import ArgumentParser

protocol SecretDelegate {

    static func loadFileInput(at url: URL) -> Data?

    static func loadStandardInput() -> Data?

    static func computeSecret(key: Data, input: Data) -> Data?

    static func writeToFile(data: Data, at url: URL) throws

    static func contentForStandardOutput(data: Data) -> Data

}

extension SecretDelegate {

    static func loadInput(at string: String?) -> Data? {
        if let string = string {
            return loadFileInput(at: .init(fileURLWithPath: string))
        } else {
            return loadStandardInput()
        }
    }

    static func writeToStandardOutput(data: Data) throws {
        let data = contentForStandardOutput(data: data)

        guard let result = String(data: data, encoding: .utf8) else {
            throw ValidationError("Failed to convert output to text. Did you mean to direct the output to a file instead?")
        }

        print(result)
    }

    static func writeOutput(data: Data, at string: String?) throws {
        if let string = string {
            try writeToFile(data: data, at: .init(fileURLWithPath: string))
        } else {
            try writeToStandardOutput(data: data)
        }
    }

}
