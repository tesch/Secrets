//
// Options.swift
//
// Created by Marcel Tesch on 2020-06-03.
// Think different.
//

import ArgumentParser

struct Options: ParsableArguments {

    @Option(name: .shortAndLong, help: "The encryption key.")
    var key: String

    @Option(name: .shortAndLong, help: "Optional file path to input data.")
    var input: String?

    @Option(name: .shortAndLong, help: "Optional file path for output data.")
    var output: String?

}

extension Options {

    func evaluate(with delegate: SecretDelegate.Type) throws {
        guard let key = key.data(using: .utf8) else {
            throw ValidationError("Failed to load key.")
        }

        guard let input = delegate.loadInput(at: input) else {
            throw ValidationError("Failed to load input.")
        }

        guard let result = delegate.computeSecret(key: key, input: input) else {
            throw ValidationError("Failed to compute output.")
        }

        try delegate.writeOutput(data: result, at: output)
    }

}
