//
//  ContentView.swift
//  YouAreAwesome
// repeat while loop, randomization, sounds, bindings
//
//  Created by Joseph Scholtz on 11/10/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    
    @State private var imageName = ""
    @State var message = ""
    @State private var audioPlayer: AVAudioPlayer!
    @State private var lastMessageNumber = -1 // lastMessageNumber will never be -1
    @State private var lastImageNumber = -1
    @State private var lastSoundNumber = -1
    @State var soundIsOn = true
    let numberOfImages = 10
    let numberOfSounds = 6
    
    var body: some View {
        
        VStack {
            
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
                .frame(height: 100)
                .animation(.easeInOut(duration: 0.15), value: imageName)
            
            Spacer()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 20)
                .animation(.default, value: imageName)
                
            Spacer()
            
            HStack {
                
                Toggle("Sound On", isOn: $soundIsOn)
                    .fixedSize(horizontal: true, vertical:  false)
                    .onChange(of: soundIsOn) {
                        if audioPlayer != nil && audioPlayer.isPlaying {
                            audioPlayer.stop()
                        }
                    }

                
                Spacer()
                
                Button("Show Message") {
                    
                    let messages = ["You are awesome!",
                                    "Gadzooks, I can't believe how utterly and completely incredeible you are my perplexing friend!",
                                    "Boadicious dude!",
                                    "You are great!",
                                    "Absolutely incredible!",
                                    "The genuis store called and they need you back!"]
               
                    lastMessageNumber = nonRepeatingRandom(lastNumber: lastMessageNumber, upperBounds: messages.count-1)
                    message = messages[lastMessageNumber]
                    
                    lastImageNumber = nonRepeatingRandom(lastNumber: lastImageNumber, upperBounds: numberOfImages-1)
                    imageName = "image" + String(lastImageNumber)
    
                    lastSoundNumber = nonRepeatingRandom(lastNumber: lastSoundNumber, upperBounds: numberOfSounds-1)
                if soundIsOn
                    {
                    playSound(soundName: "sound\(lastSoundNumber)")
                }
                }
            }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            .tint(.accentColor)
        }
        .padding()
    }
    
    func playSound (soundName: String) {
        if audioPlayer != nil && audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        
        guard let soundfile = NSDataAsset(name: soundName) else {
            print("Couldn't load sound file")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(data: soundfile.data)
            audioPlayer.play()
        } catch {
            print("Error initializing audio player: \(error.localizedDescription)")
        }
    }
    
    func nonRepeatingRandom(lastNumber: Int, upperBounds: Int) -> Int {
        
        var newNumber = Int.random(in: 0...upperBounds)
        while newNumber == lastNumber {
            newNumber = Int.random(in: 0..<upperBounds)
        }
        return newNumber
    }
}

#Preview {
    ContentView()
}
