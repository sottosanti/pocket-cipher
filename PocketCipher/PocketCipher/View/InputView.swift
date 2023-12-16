//
//  InputView.swift
//  PocketCipher
//
//  Created by Connor Sottosanti on 12/14/23.
//

import SwiftUI

struct InputView: View {
    
    // Dropdown options
    let options1 = ["Option 1", "Option 2", "Option 3"]
    let options2 = ["Choice A", "Choice B", "Choice C"]

    // State variables to track selected options
    @State private var selectedOption1 = "Option 1"
    @State private var selectedOption2 = "Choice A"
    
    @State private var textInput: String = ""
    @State private var textOutput: String = ""
    
    var body: some View {
        VStack(spacing:0) {
            toolMenu
            inputField
            convertButton
                .padding(.vertical, 20)
            outputField
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("GradientDark"), Color("GradientLight") ]),
                startPoint: .bottom,
                endPoint: .top
            )
        )
    }
    
    // MARK: - SubViews
    private var toolMenu: some View {
        HStack {
            // Dropdown menu button 1
            Menu {
                ForEach(options1, id: \.self) { option in
                    Button(action: {
                        self.selectedOption1 = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selectedOption1)
                        .padding()
                        .foregroundColor(.white)
                    Image(systemName: "chevron.down")
                        .foregroundColor(.white)
                        .padding(.trailing)
                }
                .background(Color("DefaultPurple"))
                .cornerRadius(8)
            }
            
            // Middle Text
            Text("To:")
                .foregroundColor(Color.white)
                .padding(.horizontal, 10)
            
            
            // Dropdown menu button 2
            Menu {
                ForEach(options2, id: \.self) { option in
                    Button(action: {
                        self.selectedOption2 = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selectedOption2)
                        .padding()
                        .foregroundColor(.white)
                    Image(systemName: "chevron.down")
                        .foregroundColor(.white)
                        .padding(.trailing)
                }
                .background(Color("DefaultPurple"))
                .cornerRadius(8)
            }
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
    
    private var convertButton: some View {
        Button(action: {
            // Add action for the button here
        }) {
            Text("Convert Button")
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
                Text("This is a long sample text. " +
                     "It could be several lines long and may require scrolling " +
                     "to read the entire content.")
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

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
