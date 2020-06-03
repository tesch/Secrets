//
// SecretCommand.swift
//
// Created by Marcel Tesch on 2020-06-03.
// Think different.
//

import ArgumentParser

protocol SecretCommand: ParsableCommand, SecretDelegate {

    var options: Options { get }

}

extension SecretCommand {

    func run() throws {
        try options.evaluate(with: Self.self)
    }

}
