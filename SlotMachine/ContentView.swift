//
//  ContentView.swift
//  SlotMachine
//
//  Created by Reda Mehali on 2/18/21.
//

import SwiftUI

struct ContentView: View {
    
    private var symbols = ["spin", "cherry", "apple", "banana", "watermelon", "lemon", "blackberries", "grapes", "strawberry", "star"]
    
    @State private var numbers = [0, 0, 0]
    @State private var credits = 1000
    @State private var bet : String = "10"
    @State private var disabled = false
    @State private var spinBackgroundColor = Color.pink
    
    var body: some View {
        ZStack {
            // Background
            Rectangle()
                .foregroundColor(Color(red:200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Rectangle()
                .foregroundColor(Color(red:228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45)).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            
            VStack(spacing: 20) {
                
                // Title
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("Slots Machine").bold().foregroundColor(.white)
                    
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }.scaleEffect(1.5).padding(.all, 20)
                
                Spacer().frame(height: 10)
                
                // Credits counter
                Text("Credits: \(credits)")
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white).opacity(0.5)
                    .cornerRadius(20)
                                
                HStack {
                    // Jackpot
                    Text("Jackpot")
                        .frame(width: 200, height: 40)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing], 10)
                        .background(Color.white)
                        .cornerRadius(20)
                    
                    // Jackpot
                    Text("Bet")
                        .frame(width: 120, height: 40)
                        .foregroundColor(.black)
                        .background(Color.white)
                        .cornerRadius(20)
                }

                HStack {
                    // Jackpot
                    Text("5000")
                        .frame(width: 200, height: 40)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing], 10)
                        .background(Color.white).opacity(0.5)
                        .cornerRadius(20)
                    
                    // Jackpot
                    TextField("Enter bet amount", text: $bet, onEditingChanged: {_ in
                        if (Int(bet)! > credits) {
                            print("Bet value cannot be greater than total credits")
                            disabled = true
                            spinBackgroundColor = Color.gray
                        } else {
                            disabled = false
                            spinBackgroundColor = Color.pink
                        }
                    }, onCommit: {})
                    .frame(width: 100, height: 40)
                    .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing], 10)
                        .background(Color.white).opacity(0.5)
                        .cornerRadius(20)
                }
                                   
                HStack {
                    Image("go_play_banner")
                        .resizable()
                        .frame(width: .infinity, height: 100.0)
                }
                                
                // Cards
                HStack {
                    Image(symbols[numbers[0]])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Image(symbols[numbers[1]])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Image(symbols[numbers[2]])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                }
                                                            
                // Button Spin
                Button(action: {
                    if (Int(bet)! > credits) {
                        return
                    }
                    credits = credits - Int(bet)!
                    // Spin Action
                    self.numbers[0] = Int.random(in: 0...symbols.count - 1)
                    self.numbers[1] = Int.random(in: 0...symbols.count - 1)
                    self.numbers[2] = Int.random(in: 0...symbols.count - 1)
                }) {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all, 10)
                        .padding([.leading, .trailing], 30)
                        .background(spinBackgroundColor)
                        .cornerRadius(20)
                }.disabled(disabled)
                
                HStack {
                    // Button reset
                    Button(action: {
                        // Reset action
                        self.numbers[0] = 0
                        self.numbers[1] = 0
                        self.numbers[2] = 0
                    }) {
                        Text("Reset")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 30)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                    // Button reset
                    Button(action: {
                        // Quit action
                        exit(0)
                    }) {
                        Text("Quit")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 30)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
