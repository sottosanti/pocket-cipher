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
    
    // Decrypt function for the Caesar Cipher
    func caesarCipherDecryptor(_ text: String, shift: Int) -> String {
        // Calculate the inverse shift value by using a negative shift
        let inverseShift = (26 - (shift % 26)) % 26

        let lowerCaseLetters = Array("abcdefghijklmnopqrstuvwxyz")
        let upperCaseLetters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")

        return String(text.map { char in
            if let idx = lowerCaseLetters.firstIndex(of: char) {
                return lowerCaseLetters[(idx + inverseShift) % 26]
            } else if let idx = upperCaseLetters.firstIndex(of: char) {
                return upperCaseLetters[(idx + inverseShift) % 26]
            } else {
                return char
            }
        })
    }
    
    // Function for the ROT13 Cipher
    func rot13(_ text: String) -> String {
        return caesarCipher(text, shift: 13)
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
    
    // Decrypt function for the Atbash Cipher 
    func atbashCipherDecryptor(_ text: String) -> String {
        let alphabet = Array("abcdefghijklmnopqrstuvwxyz")
        let reversedAlphabet = Array(alphabet.reversed())

        return String(text.map { char in
            if let idx = reversedAlphabet.firstIndex(of: char) {
                return alphabet[idx]
            } else if let idx = reversedAlphabet.firstIndex(of: char.lowercased().first!) {
                return alphabet[idx].uppercased().first!
            } else {
                return char
            }
        })
    }
    

    
}
