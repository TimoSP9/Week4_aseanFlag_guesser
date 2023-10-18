//
//  ContentView.swift
//  TestW04
//
//  Created by Timotius.
//

import SwiftUI

struct ContentView: View {
    var asean: [String] = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    @State private var showResult = false
    @State private var correctGuesses: Int = 0
    @State private var currentCountry: String = ""
    @State private var selectedCountries: [String] = []
    @State private var alertShown = false

    func randomizedCountries() {
        if selectedCountries.count < 10 {
            var randomCountry = asean.randomElement()!
            while selectedCountries.contains(randomCountry) {
                randomCountry = asean.randomElement()!
            }
            currentCountry = randomCountry
            selectedCountries.append(randomCountry)
        }
    }

    func countryPressed(number: Int) {
        if asean[number] == currentCountry {
            correctGuesses += 1
        }
        if selectedCountries.count == 10 {
            alertShown = true
        }
        randomizedCountries()
    }

    var body: some View {
        ZStack {
            Color.mint
                .ignoresSafeArea()
            VStack {
                Text("Choose Your Flag !!!")
                    .foregroundStyle(.black)
                Text(currentCountry)
                    .foregroundStyle(.black)
                if showResult {
                    Text("Correct")
                        .foregroundColor(.green)
                }
            }
        }
        .onAppear() {
            randomizedCountries()
        }

        HStack {
            Spacer()
            VStack {
                ForEach(0 ..< 5, id: \.self) { number in
                    Button {
                        countryPressed(number: number)
                    } label: {
                        Image(asean[number])
                            .resizable()
                            .frame(width: 105, height: 65)
                    }
                }
            }
            Spacer()
            VStack {
                ForEach(5 ..< 10, id: \.self) { number in
                    Button {
                        countryPressed(number: number)
                    } label: {
                        Image(asean[number])
                            .resizable()
                            .frame(width: 105, height: 65)
                    }
                }
            }
            Spacer()
        }
        .alert("Congrats!", isPresented: $alertShown) {
            Button("Wanna Play Let's Play", role: .cancel) {
                selectedCountries = []
                correctGuesses = 0
                randomizedCountries()
                alertShown = false
            }
        } message: {
            Text("You has correctly answer \(correctGuesses) and wrong \(10 - correctGuesses) from 10 ASEAN Country")
        }
    }
}

#Preview {
    ContentView()
}
