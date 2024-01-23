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
            
            Image("LogoTransparent")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(3)
                .background(Color("GradientDark").opacity(0.08))
                .clipShape(Circle())
                //.overlay(Circle().stroke(Color.gray.opacity(0.2), lineWidth: 1))
                .overlay(Circle().stroke(Color.yellow.opacity(0.4), lineWidth: 1))
                .padding(.leading, 10)
        
            Text("PocketCipher")
                .foregroundGradient(
                    Gradient(colors: [Color("Gold"), Color.yellow]) // Customize the colors as needed
                )
                .font(Font.system(size: 18))
                .padding(.leading, 7)
            
            Spacer()
            
        } //end HStack
        .frame(height: UIScreen.main.bounds.height * 0.07)
        .background(Color("GradientLightLight"))
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 1)
        
    }
}

extension View {
    func foregroundGradient(_ gradient: Gradient) -> some View {
        self.overlay(LinearGradient(gradient: gradient, startPoint: .bottom, endPoint: .top)
            .mask(self))
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
