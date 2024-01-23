//
//  InputView.swift
//  PocketCipher
//
//  Created by Connor Sottosanti on 12/14/23.
//

import SwiftUI

struct InputView: View {
    
    /*
    let cipherOptions = ["Caesar Cipher", "Atbash Cipher", "ROT13", "Text to Binary", "Binary to Text", "Text to Hex", "Hex to Text", "Text to Base64", "Base64 to Text"]
     */
     
    // Caesar Cipher rotations
    let caesarRotations = Array(0...25).map { "\($0)" }
    
    // State variables to track selected options
    @State private var selectedRotation = "0"
    @State private var textInput: String = ""
    @State private var textOutput: String = ""
    
    //new vars
    let actionOptions = ["Encrypt", "Decrypt"]
    @State private var selectedAction = "Encrypt"
    let algoOptions = ["Caesar Cipher", "Atbash Cipher", "ROT13", "Binary", "Hex", "Base64"]
    @State private var selectedAlgo = "Select"
    
    
    var body: some View {
        VStack(spacing:0) {
            interactionMenu
            inputField
            convertButton
            outputField
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("GradientLightDark2"), Color("GradientLightLight")]),
                startPoint: .bottom,
                endPoint: .top
            )
        )
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    // MARK: - SubViews
    private var interactionMenu: some View {
        HStack(spacing: 10) {
            actionMenu
            algoOptionMenu
            
            if selectedAlgo == "Caesar Cipher" {
                rotationMenu
            }
            
        } //end HStack with [action, algos, rotations]
        .frame(height: UIScreen.main.bounds.height * 0.08)
        .padding(.vertical, 20)
        
        
    }
    
    private var actionMenu: some View {
        Menu {
            ForEach(actionOptions, id: \.self) { action in
                Button(action: {
                    self.selectedAction = action
                }) {
                    Text(action)
                }
            }
        } label: {
            VStack(spacing: 0) {
                Text("Action")
                    .foregroundColor(Color("GoldLight"))
                    .font(.system(size: 14))
                    .padding(.bottom, 5)
                
                HStack {
                    Text(selectedAction)
                        .foregroundColor(.white)
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.yellow.opacity(0.8))
                        .padding(.trailing)
                } //end HStack
                .padding(.vertical, 15)
                .padding(.leading, 15)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.yellow.opacity(0.8), lineWidth: 1) // Adjust the lineWidth as needed
                )
                .background(Color.clear)
                .cornerRadius(8)
            } //end Vstack with "Action" and Menu
        } //end Label
    }
    
    private var algoOptionMenu: some View {
        Menu {
            ForEach(algoOptions, id: \.self) { algo in
                Button(action: {
                    self.selectedAlgo = algo
                }) {
                    Text(algo)
                }
            }
        } label: {
            VStack(spacing: 0) {
                Text(selectedAction == "Encrypt" ? "To:" : "From:")
                    .foregroundColor(Color("GoldLight"))
                    .font(.system(size: 14))
                    .padding(.bottom, 5)
                
                HStack {
                    Text(selectedAlgo)
                        .foregroundColor(.white)
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.yellow.opacity(0.8))
                        .padding(.trailing)
                } //end HStack
                .padding(.vertical, 15)
                .padding(.leading, 15)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.yellow.opacity(0.8), lineWidth: 1) // Adjust the lineWidth as needed
                )
                .background(Color.clear)
                .cornerRadius(8)
            }
        }//end VStack with "Algorithm" and Menu
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
            VStack(spacing: 0) {
                Text("Rotations")
                    .foregroundColor(Color("GoldLight"))
                    .font(.system(size: 14))
                    .padding(.bottom, 5)
                
                HStack {
                    Text("\(selectedRotation)")
                        .foregroundColor(.white)
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.yellow)
                        .padding(.trailing)
                }
                .padding(.vertical, 15)
                .padding(.leading, 15)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.yellow, lineWidth: 1) // Adjust the lineWidth as needed
                )
                .background(Color.clear)
                .cornerRadius(8)
            }
        }
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
    
    private var convertButton: some View {
        Button(action: {
            // Convert text based on the selected cipher
            if (selectedAction == "Encrypt") {
                switch selectedAlgo {
                case "Caesar Cipher":
                    let rotation = Int(selectedRotation) ?? 0
                    textOutput = Ciphers().caesarCipher(textInput, shift: rotation)
                case "Atbash Cipher":
                    textOutput = Ciphers().atbashCipher(textInput)
                case "ROT13":
                    textOutput = Ciphers().rot13(textInput)
                case "Binary":
                    textOutput = DataFormatter().textToBinary(textInput)
                case "Hex":
                    textOutput = DataFormatter().textToHex(textInput)
                case "Base64":
                    textOutput = DataFormatter().textToBase64(textInput)
                default:
                    textOutput = ""
                }
            }
            else { //decrpyt
                switch selectedAlgo {
                case "Caesar Cipher":
                    let rotation = Int(selectedRotation) ?? 0
                    textOutput = Ciphers().caesarCipher(textInput, shift: rotation)
                case "Atbash Cipher":
                    textOutput = Ciphers().atbashCipher(textInput)
                case "ROT13":
                    textOutput = Ciphers().rot13(textInput)
                case "Binary":
                    textOutput = DataFormatter().binaryToText(textInput)
                case "Hex":
                    textOutput = DataFormatter().hexToText(textInput)
                case "Base64":
                    textOutput = DataFormatter().base64ToText(textInput)
                default:
                    textOutput = ""
                }
            }
            
            
        }) {
            Text(selectedAction == "Encrypt" ? "Encrypt" : "Decrypt")
                .foregroundColor(Color("GradientLightDark"))
                .frame(width: 150, height: 50)
                .background(Color("GoldButton").opacity(0.9))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("GoldDark"), lineWidth: 1) // Adjust the lineWidth as needed
                )
                .padding(.vertical, 20)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 3)
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
                    LinearGradient(gradient: Gradient(colors: [Color("Gold"), Color.yellow.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                )
                .cornerRadius(8)
                .shadow(color: Color.black.opacity(0.2), radius: 3, x: 1, y: 4)
        }
    }
    
    private var outputField: some View {
        VStack(spacing: 0) {
            ScrollView {
                HStack {
                    Text(textOutput)
                        .padding()
                        .foregroundColor(.white)

                    Spacer()

                    // Copy Button
                    Button(action: {
                        UIPasteboard.general.string = textOutput
                    }) {
                        Image(systemName: "doc.on.doc")
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(10)

            // Up Arrow Button
            Button(action: {
                textInput = textOutput
            }) {
                Image(systemName: "arrow.up")
                    .foregroundColor(.white)
                    .padding()
            }
        }
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
