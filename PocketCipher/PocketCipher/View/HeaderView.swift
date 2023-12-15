//
//  HeaderView.swift
//  PocketCipher
//
//  Created by Connor Sottosanti on 12/14/23.
//

import SwiftUI

struct HeaderView: View {
    
    var body: some View {
        
            
        HStack(spacing: 0) { //header with logo
            
            Spacer()
            
            Image("LogoTransparent")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 54, height: 54)
                .padding(3)
                .background(Color("GradientDark").opacity(0.1))
                .clipShape(Circle())
                //.overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
                .overlay(Circle().stroke(Color.yellow.opacity(0.4), lineWidth: 1))
            
            Spacer()
            
        } //end HStack
        .frame(height: UIScreen.main.bounds.height * 0.09)
        .background(Color("GradientLight"))
        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 1)
        
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
