//
//  GameButtonsView.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 1/14/20.
//  Copyright © 2020 zvilardell. All rights reserved.
//

import SwiftUI

struct GameButtonsView: View {
    
    var body: some View {
        
        NavigationView {
            ZStack {
                //set background color
                Color.black
                .edgesIgnoringSafeArea(.all)
                
                //buttons
                VStack {
                    GameButton(title: "Breaking Bad")
                    GameButton(title: "Ron Swanson")
                    GameButton(title: "Kanye West")
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct GameButton: View {
    
    let title: String
    
    init(title: String) {
        self.title = title
    }

    var body: some View {
        //navigation link only working once in preview/simulator due to Xcode bug
        NavigationLink(destination: ResultsView()) {
            Text(title)
            .font(Font.system(size: 15))
            .foregroundColor(Color.white)
            .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 55.0, maxHeight: 55.0)
            .background(Color(red: 170 / 255, green: 86 / 255, blue: 38 / 255))
            .cornerRadius(5)
            .padding([.vertical])
        }
    }
}

struct GameButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        GameButtonsView()
    }
}
