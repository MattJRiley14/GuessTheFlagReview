//
//  ContentView.swift
//  GuessTheFlagReview
//
//  Created by BCCS 2022 on 10/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    // CHALLENGE 1
    @State private var userScore = 0
    
    // CHALLENGE 3
    @State private var finalAlert = false
    @State private var questionNumber = 0
    
    var body: some View {
        ZStack {
            // Color.blue
                // .ignoresSafeArea()
            
            // LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                // .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)            ], center: .top, startRadius: 200, endRadius: 700)

            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                // VStack(spacing: 30) {
                    VStack {
                        Text("Tap the Flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            // .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            // flag was tapped
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                // CHALLENGE 1
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            
            // CHALLENGE 1
             // Text("Your score is \(userScore)")
            
            // CHALLENGE 3
            Text("Your score is \(userScore). \(8 - questionNumber) question(s) left.")
        }

        // CHALLENGE 3
        .alert(scoreTitle, isPresented: $finalAlert){
            Button("Play Again?", action: reset)
        } message: {
            Text("Final score is \(userScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        
        // CHALLENGE 3
        questionNumber += 1

        if number == correctAnswer {
            scoreTitle = "Correct"
            
            // CHALLENGE 1
            userScore += 1
            
        } else {
            
            // CHALLENGE 2
            scoreTitle = "Wrong! That is the flag of \(countries[number])"
            
            // CHALLENGE 1
            if userScore > 0 {
                userScore -= 1
            }
        }
              
        // CHALLENGE 3
        if questionNumber < 8 {
            showingScore = true
        } else {
            finalAlert = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    // CHALLENGE 3
    func reset(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionNumber = 0
        userScore = 0
    }
}

#Preview {
    ContentView()
}
