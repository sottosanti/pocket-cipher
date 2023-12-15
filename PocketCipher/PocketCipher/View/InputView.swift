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
            Spacer()
            toolMenu
            inputField
                .padding(.bottom, 20)
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
                    Image(systemName: "chevron.down") // Downward chevron icon
                        .foregroundColor(.white)
                        .padding(.trailing)
                }
                .background(Color("DefaultPurple")) // Changed color to purple
                .cornerRadius(8)
            }
            
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
                .foregroundColor(.black)
                .accentColor(.black)
                .cornerRadius(10)
                .frame(width: UIScreen.main.bounds.width * 0.9, height: 200, alignment: .leading)
        }
        //.padding()
    }
    
    private var outputField: some View {
        
            TextEditor(text: $textInput)
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .padding(10)
            .scrollContentBackground(.hidden) //opaque background
            .background(Color.gray.opacity(0.4))
            .foregroundColor(.black)
            .accentColor(.black)
            .cornerRadius(10)
            .frame(width: UIScreen.main.bounds.width * 0.9, height: 200, alignment: .leading)
    }
  
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
