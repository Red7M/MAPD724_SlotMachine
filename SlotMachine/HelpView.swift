//
//  HelpView.swift
//  SlotMachine
//
//  Created by Reda Mehali on 3/9/21.
//  Student ID: 301-159-604

//  This is the help screen of the slot
//  machine game. It contains help information
//  on how the game works, what's a jackpot, and
//  how much money players make from each spinning
//  combination result. 

import SwiftUI

struct HelpView: View {
    var body: some View {
        ZStack {
            // Background
            Rectangle()
                .foregroundColor(Color(red:200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            
            Rectangle()
                .foregroundColor(Color(red:228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: -45)).edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 8) {
                ScrollView {
                HStack (alignment: .center, spacing: 10){
                    Spacer()
                    Text("Welcome to Slots Machine!!").bold()
                    Spacer()
                }.padding(10)
                
                HStack (){
                    Text("How it works? (The boring part)").bold()
                    Spacer()
                }
                
                HStack (alignment: .top, spacing: 10){
                    Text("* Users will start off with 1000 points of credit. The default inserted value that the user can bet is '10'. If you would like to bet more or less, all you have to do is enter the amount that you would like to bet. The more you bet, the higher are your chances of winning more money.")
                }.padding(10)
                
                HStack (spacing: 10){
                    Text("Jackpot").bold()
                    Spacer()
                }.padding(2)
                
                HStack (spacing: 10){
                    Text("Jackpot starts at 5000 dollars on a freshly started game. We hope that you will hit it from the first try, but if you don't , not a problem. Why? Because, every ten tries, an addtional 5000 dollars is added to the jackpot, which means you have a chance of winning more money! How cool is that!")
                    Spacer()
                }.padding(10)
                
                HStack (spacing: 10){
                    Text("Winning Combinations (it's all about the fruits)").bold()
                    Spacer()
                }.padding(2)
                
                Group {
                    HStack (spacing: 10){
                        Text("2 cherries, 2 bananas, 2 watermelon, 2 lemons, 2 blackberries, 2 grapes, 2 strawberries, 2 stars, and 1 star gets you bet*2, bet*2, bet*3, bet*4, bet*5, bet*10, bet*20, bet*50, and bet*1 respectively. ")
                        Spacer()
                    }.padding(2)
                    HStack (spacing: 10){
                        Text(" 3 cherries = Your bet * 10")
                        Spacer()
                    }
                    HStack (spacing: 10){
                        Text(" 3 bananas = Your bet * 20")
                        Spacer()
                    }
                    HStack (spacing: 10){
                        Text(" 3 watermelons = Your bet * 30")
                        Spacer()
                    }
                    HStack (spacing: 10){
                        Text(" 3 lemons = Your bet * 40")
                        Spacer()
                    }
                    HStack (spacing: 10){
                        Text(" 3 blackberries = Your bet * 50")
                        Spacer()
                    }
                    HStack (spacing: 10){
                        Text(" 3 grapes = Your bet * 75")
                        Spacer()
                    }
                    HStack (spacing: 10){
                        Text(" 3 strawberries = Your bet * 100")
                        Spacer()
                    }
                    HStack (spacing: 10){
                        Text(" 3 stars = jackpot")
                        Spacer()
                    }
                }
            }
            }
        }
    }
}
