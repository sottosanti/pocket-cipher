//
//  InputView.swift
//  PocketCipher
//
//  Created by Connor Sottosanti on 12/14/23.
//

import SwiftUI

struct InputView: View {
    
    // Cipher options
    let cipherOptions = ["Caesar Cipher", "Atbash Cipher", "ROT13"]

    // Caesar Cipher rotations
    let caesarRotations = Array(0...25).map { "\($0)" }
    
    // State variables to track selected options
    @State private var selectedCipher = "Caesar Cipher"
    @State private var selectedRotation = "0"
    @State private var textInput: String = ""
    @State private var textOutput: String = ""
    
    var body: some View {
        VStack(spacing:0) {
            cipherMenu
            if selectedCipher == "Caesar Cipher" {
                rotationMenu
            }
            inputField
            buttonRow
            outputField
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("GradientDark"), Color("GradientLight")]),
                startPoint: .bottom,
                endPoint: .top
            )
        )
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    // MARK: - SubViews
    private var cipherMenu: some View {
        Menu {
            ForEach(cipherOptions, id: \.self) { cipher in
                Button(action: {
                    self.selectedCipher = cipher
                }) {
                    Text(cipher)
                }
            }
        } label: {
            HStack {
                Text(selectedCipher)
                    .padding()
                    .foregroundColor(.white)
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
            .background(Color("DefaultPurple"))
            .cornerRadius(8)
        }
        .padding()
    }
    
    private var rotationMenu: some View {
        Menu {
            ForEach(caesarRotations, id: \.self) { rotation in
                Button(action: {
                    self.selectedRotation = rotation
                }) {
                    Text(rotation)
                }
            }
        } label: {
            HStack {
                Text("Rotation: \(selectedRotation)")
                    .padding()
                    .foregroundColor(.white)
                Image(systemName: "chevron.down")
                    .foregroundColor(.white)
                    .padding(.trailing)
            }
            .background(Color("DefaultPurple"))
            .cornerRadius(8)
        }
        .padding()
    }
    
    private var inputField: some View {
        //Custom text editor with placeholder text
        ZStack(alignment: .topLeading) {
            if textInput.isEmpty {
                Text("Enter text here")
                    .foregroundColor(Color.white)
                    .padding(.top, 18)
                    .padding(.leading, 16)
            }
            
            TextEditor(text: $textInput)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding(10)
                .scrollContentBackground(.hidden) //opaque background
                .background(Color.gray.opacity(0.4))
                .foregroundColor(Color.white)
                .accentColor(Color.yellow)
                .cornerRadius(10)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 200, alignment: .leading)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(0.2), lineWidth: 1))
    }
    
    private var buttonRow: some View {
        HStack {
            convertButton
            if selectedCipher == "Caesar Cipher" {
                allRotationsButton
            }
        }
        .padding(.vertical, 20)
    }
    
    private var convertButton: some View {
        Button(action: {
            // Convert text based on the selected cipher
            switch selectedCipher {
            case "Caesar Cipher":
                let rotation = Int(selectedRotation) ?? 0
                textOutput = Ciphers().caesarCipher(textInput, shift: rotation)
            case "Atbash Cipher":
                textOutput = Ciphers().atbashCipher(textInput)
            case "ROT13":
                textOutput = Ciphers().rot13(textInput)
            case "Caesar - All Rotations":
                textOutput = allCaesarRotations(text: textInput)
            default:
                textOutput = ""
            }
        }) {
            Text("Convert")
                .foregroundColor(.white)
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("Gold"), Color.yellow.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 4)
        }
    }
    
    private var allRotationsButton: some View {
        Button(action: {
            textOutput = allCaesarRotations(text: textInput)
        }) {
            Text("All Rotations")
                .foregroundColor(.white)
                .padding()
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color("Gold"), Color.yellow.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 4)
        }
    }
    
    private var outputField: some View {
        
        VStack(spacing: 0) {
            ScrollView {
                Text(textOutput)
                    .padding()
                    .foregroundColor(.white)
                
            }
        }//end VStack
        .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
        .background(Color.gray.opacity(0.4))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black.opacity(0.3), lineWidth: 1))
  
    }
}

// MARK: - Functions
private func allCaesarRotations(text: String) -> String {
    return (0..<26).map { rotation -> String in
        "Rotation \(rotation): \(Ciphers().caesarCipher(text, shift: rotation))"
    }.joined(separator: "\n")
}

private func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
// MARK: - Previews
struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
