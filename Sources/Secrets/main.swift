//
// main.swift
//
// Created by Marcel Tesch on 2020-06-03.
// Think different.
//

import ArgumentParser

struct Secrets: ParsableCommand {

    static let configuration = CommandConfiguration(abstract: "256-bit AES encryption and decryption.", subcommands: [Encrypt.self, Decrypt.self])

}

Secrets.main()
