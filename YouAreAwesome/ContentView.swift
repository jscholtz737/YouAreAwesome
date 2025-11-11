//
//  ContentView.swift
//  YouAreAwesome
//
//  Created by Joseph Scholtz on 11/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var imageName = ""
    @State private var message = ""
    @State var imageCounter = 0
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 20)
                
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
            
            Spacer()
            
            HStack {
                Button("Press Me!") {
                    let message1 = "You are awesome!"
                    let message2 = "You are amazing!"
                    
                    imageCounter += 1
                    if imageCounter == 9 {
                        imageCounter = 0
                    }
                        
                    imageName = "image" + String(imageCounter)
                    message = message == message1 ? message2 : message1
                }
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
