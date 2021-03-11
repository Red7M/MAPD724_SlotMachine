//
//  HelpView.swift
//  SlotMachine
//
//  Created by Reda Mehali on 3/9/21.
//  Student ID: 301-159-604

//  This is the main screen of the slot
//  machine game. It contains a set of views
//  like (jackpot amount, highest payout, help
//  nav button, spinning reels, and so on.

import SwiftUI

// Reels symboles variables
var blanks = 0
var cherry = 0
var banana = 0
var watermelon = 0
var lemon = 0
var blackberries = 0
var grapes = 0
var strawberry = 0
var star = 0

private var symbols = ["spin", "spin", "spin"]
private var numbers = [0, 0, 0]

var winnings = 0
var playerBet = 0

struct UserCredit {
    var credits = 1000
    var bet : String = "10"
    var jackpot = 5000
    var tries = 0
    // Tie to data persistance
    var highestAmount = UserDefaults.standard.integer(forKey: "highestAmount")
    
    var showingAlert = false
}

struct ContentView: View {
    @State private var disabled = false
    @State var isModal: Bool = false
    @State private var spinBackgroundColor = Color.pink
    @State private var userCredit = UserCredit()
    
    var body: some View {
        ZStack {
            // Background
            Rectangle()
                .foregroundColor(Color(red:200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color(red:228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45)).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 8) {
                HStack {
                    Text(" highest payout: \(userCredit.highestAmount)")
                        .foregroundColor(.white).font(.system(size: 20))
                    Spacer()
                    Button(action: {
                            self.isModal = true
                        }) {
                        Image("help").resizable().frame(width: 32, height: 32)
                        }.sheet(isPresented: $isModal, content: {
                            HelpView()
                        }).padding(.trailing, 8)
                }

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
                Text("Credits: \(userCredit.credits)")
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
                    Text(String(userCredit.jackpot))
                        .frame(width: 200, height: 40)
                        .foregroundColor(.black)
                        .padding([.leading, .trailing], 10)
                        .background(Color.white).opacity(0.5)
                        .cornerRadius(20)
                    
                    // Jackpot
                    TextField("Enter bet amount", text: $userCredit.bet, onEditingChanged: {_ in
                        playerBet = Int(userCredit.bet)!
                        if (Int(userCredit.bet)! > userCredit.credits) {
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
                    Image(symbols[0])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Image(symbols[1])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                    
                    Image(symbols[2])
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(20)
                }
                                                            
                // Button Spin
                Button(action: {
                    if (Int(userCredit.bet)! > userCredit.credits) {
                        return
                    }
                    userCredit.credits = userCredit.credits - Int(userCredit.bet)!
                    
                    // Spin Action
                    spinReels()
                    determineWinnings(userCredit: &userCredit)
                }) {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all, 10)
                        .padding([.leading, .trailing], 30)
                        .background(spinBackgroundColor)
                        .cornerRadius(20)
                }.disabled(disabled)
                .alert(isPresented:$userCredit.showingAlert) {
                            Alert(
                                title: Text("Congratulations! You Won the Jackpot!!!"),
                                message: Text(String(userCredit.jackpot)),
                                dismissButton: .destructive(Text("***YAY***")) {
                                    print("***YAY***")
                                }
                            )
                        }
                
                HStack {
                    // Button reset
                    Button(action: {
                        // Reset action
                        numbers[0] = 0
                        numbers[1] = 0
                        numbers[2] = 0
                        
                        symbols[0] = "spin"
                        symbols[1] = "spin"
                        symbols[2] = "spin"
                        
                        userCredit.credits = 1000
                        userCredit.jackpot = 5000
                        userCredit.bet = "10"
                    }) {
                        Text("Reset")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 10)
                            .padding([.leading, .trailing], 30)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                    // Button Quit
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

func spinReels() -> [String] {

    for spin in 0...2 {
        numbers[spin] = Int(((drand48() * 70) + 1).rounded(.down))
        switch numbers[spin] {
        case checkRange(value: numbers[spin], lowerBounds: 1, upperBounds: 27):
            symbols[spin] = "blanks";
            blanks += 1
        case checkRange(value: numbers[spin], lowerBounds: 28, upperBounds: 37):
            symbols[spin] = "cherry";
            cherry += 1
        case checkRange(value: numbers[spin], lowerBounds: 38, upperBounds: 46):
            symbols[spin] = "banana";
            banana += 1
        case checkRange(value: numbers[spin], lowerBounds: 47, upperBounds: 54):
            symbols[spin] = "watermelon";
            watermelon += 1
        case checkRange(value: numbers[spin], lowerBounds: 55, upperBounds: 59):
            symbols[spin] = "lemon";
            lemon += 1
        case checkRange(value: numbers[spin], lowerBounds: 60, upperBounds: 62):
            symbols[spin] = "blackberries";
            blackberries += 1
        case checkRange(value: numbers[spin], lowerBounds: 63, upperBounds: 64):
            symbols[spin] = "grapes";
            grapes += 1
        case checkRange(value: numbers[spin], lowerBounds: 65, upperBounds: 68):
            symbols[spin] = "strawberry";
            strawberry += 1
        case checkRange(value: numbers[spin], lowerBounds: 69, upperBounds: 70):
            symbols[spin] = "star";
            star += 1
        default:
            symbols[spin] = " "
        }
    }
    return symbols
}

private func determineWinnings( userCredit : inout UserCredit) {
    if (blanks == 0) {
        if (cherry == 3) {
            winnings = Int(userCredit.bet)! * 10;
        }
        else if (banana == 3) {
            winnings = Int(userCredit.bet)! * 20;
        }
        else if (watermelon == 3) {
            winnings = Int(userCredit.bet)! * 30;
        }
        else if (lemon == 3) {
            winnings = Int(userCredit.bet)! * 40;
        }
        else if (blackberries == 3) {
            winnings = Int(userCredit.bet)! * 50;
        }
        else if (grapes == 3) {
            winnings = Int(userCredit.bet)! * 75;
        }
        else if (strawberry == 3) {
            winnings = Int(userCredit.bet)! * 100;
        }
        else if (star == 3) {
            winnings = userCredit.jackpot;
            userCredit.tries = 0
            
            // show special message after winning jackpot
            userCredit.showingAlert = true;

        }
        else if (cherry == 2) {
            winnings = Int(userCredit.bet)! * 2;
        }
        else if (banana == 2) {
            winnings = Int(userCredit.bet)! * 2;
        }
        else if (watermelon == 2) {
            winnings = Int(userCredit.bet)! * 3;
        }
        else if (lemon == 2) {
            winnings = Int(userCredit.bet)! * 4;
        }
        else if (blackberries == 2) {
            winnings = Int(userCredit.bet)! * 5;
        }
        else if (grapes == 2) {
            winnings = Int(userCredit.bet)! * 10;
        }
        else if (strawberry == 2) {
            winnings = Int(userCredit.bet)! * 20;
        }
        else if (star == 2) {
            winnings = Int(userCredit.bet)! * 50;
        }
        else if (star == 1) {
            winnings = Int(userCredit.bet)! * 5;
        }
        else {
            winnings = Int(userCredit.bet)! * 1;
        }
        onUpdateHighestPayOutAmount(highestAmount: &userCredit.highestAmount, newAmount: winnings)
        print("Win!");
        print("The amount won is \(winnings)");
        userCredit.credits = userCredit.credits + winnings
    }
    else {
        print("Loss!");
    }
    increaseJackpotAfterTenTries(userCredit: &userCredit)
    resetFruitTally();
}

private func onUpdateHighestPayOutAmount(highestAmount: inout Int, newAmount: Int) {
    if (newAmount > highestAmount) {
        UserDefaults.standard.set(newAmount, forKey: "highestAmount")
        highestAmount = newAmount
    }
}

private func increaseJackpotAfterTenTries(userCredit: inout UserCredit) {
    // Increase jackpot by 5000 after 10 tries
    if (userCredit.tries > 8) {
        userCredit.jackpot += 5000
        userCredit.tries = 0
    } else {
        userCredit.tries += 1
    }
}

private func checkRange(value: Int, lowerBounds: Int, upperBounds: Int) -> Int{
    return (value >= lowerBounds && value <= upperBounds) ? value : -1
}

private func resetFruitTally() {
    blanks = 0
    cherry = 0
    banana = 0
    watermelon = 0
    lemon = 0
    blackberries = 0
    grapes = 0
    strawberry = 0
    star = 0
    
    // Reset winning score
    winnings = 0
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
        }
    }
}
