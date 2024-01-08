//
//  DataFormatter.swift
//  PocketCipher
//
//  Created by Stephen Sottosanti on 1/8/24.
//

import Foundation

class DataFormatter {

    // Convert from text to binary
    func textToBinary(_ text: String) -> String {
        let binaryStrings = text.utf8.map { byte -> String in
            let binary = String(byte, radix: 2)
            let padding = String(repeating: "0", count: 8 - binary.count)
            return padding + binary
        }
        return binaryStrings.joined(separator: " ")
    }

    // Convert from binary to text
    func binaryToText(_ binary: String) -> String {
        let bytes = binary.split(separator: " ").compactMap { UInt8($0, radix: 2) }
        return String(bytes: bytes, encoding: .utf8) ?? "Error"
    }

    // Convert from text to hex
    func textToHex(_ text: String) -> String {
        return text.utf8.map { String(format: "%02x", $0) }.joined(separator: " ")
    }

    // Convert from hex to text
    func hexToText(_ hex: String) -> String {
        // Remove all whitespaces from the input string
        let cleanedHex = hex.filter { !$0.isWhitespace }

        // Check if the cleaned string is a valid hexadecimal
        let hexCharacterSet = CharacterSet(charactersIn: "0123456789ABCDEFabcdef")
        if cleanedHex.rangeOfCharacter(from: hexCharacterSet.inverted) != nil {
            // If there are characters outside the hexadecimal set
            return "this is not hex"
        }

        var bytes = [UInt8]()
        var startIndex = cleanedHex.startIndex

        while startIndex < cleanedHex.endIndex {
            let endIndex = cleanedHex.index(startIndex, offsetBy: 2, limitedBy: cleanedHex.endIndex) ?? cleanedHex.endIndex
            let hexSubString = cleanedHex[startIndex..<endIndex]

            // Ensure each substring has exactly two characters
            if hexSubString.count != 2 {
                return "this is not hex"
            }

            if let byte = UInt8(hexSubString, radix: 16) {
                bytes.append(byte)
            } else {
                return "this is not hex"
            }
            startIndex = endIndex
        }

        return String(bytes: bytes, encoding: .utf8) ?? ""
    }


    // Convert from text to hexdump
    func textToHexDump(_ text: String) -> String {
        let hex = textToHex(text)
        return stride(from: 0, to: hex.count, by: 32).map {
            let endIndex = hex.index(hex.startIndex, offsetBy: min(32, hex.count - $0))
            return String(hex[hex.index(hex.startIndex, offsetBy: $0)..<endIndex])
        }.joined(separator: "\n")
    }

    // Convert from hexdump to text
    func hexDumpToText(_ hexDump: String) -> String {
        return hexToText(hexDump.replacingOccurrences(of: "\n", with: ""))
    }

    // Convert from text to base64
    func textToBase64(_ text: String) -> String {
        return Data(text.utf8).base64EncodedString()
    }

    // Convert from base64 to text
    func base64ToText(_ base64: String) -> String {
        guard let data = Data(base64Encoded: base64) else { return "Error" }
        return String(data: data, encoding: .utf8) ?? "Error"
    }
}

