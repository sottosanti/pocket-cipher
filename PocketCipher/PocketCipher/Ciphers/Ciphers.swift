//
//  Ciphers.swift
//  PocketCipher
//
//  Created by Stephen Sottosanti on 12/18/23.
//

import Foundation

class Ciphers {

    // Function for the Caesar Cipher
    func caesarCipher(_ text: String, shift: Int) -> String {
        let lowerCaseLetters = Array("abcdefghijklmnopqrstuvwxyz")
        let upperCaseLetters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

        return String(text.map { char in
            if let idx = lowerCaseLetters.firstIndex(of: char) {
                return lowerCaseLetters[(idx + shift) % 26]
            } else if let idx = upperCaseLetters.firstIndex(of: char) {
                return upperCaseLetters[(idx + shift) % 26]
            } else {
                return char
            }
        })
    }

    // Function for the Atbash Cipher
    func atbashCipher(_ text: String) -> String {
        let alphabet = Array("abcdefghijklmnopqrstuvwxyz")
        let reversedAlphabet = Array(alphabet.reversed())

        return String(text.map { char in
            if let idx = alphabet.firstIndex(of: char) {
                return reversedAlphabet[idx]
            } else if let idx = alphabet.firstIndex(of: char.lowercased().first!) {
                return reversedAlphabet[idx].uppercased().first!
            } else {
                return char
            }
        })
    }

    // Function for the ROT13 Cipher
    func rot13(_ text: String) -> String {
        return caesarCipher(text, shift: 13)
    }
}
