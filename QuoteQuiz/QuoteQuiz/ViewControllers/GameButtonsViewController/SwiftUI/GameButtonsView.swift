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
        ZStack {
            //set background color
            Color.red
            .edgesIgnoringSafeArea(.all)
            
            //buttons
            VStack {
                Button(action: {
                    print("Hey")
                }) {
                    Text("Yo")
                }
            }
        }
    }
}

//struct GameButton: View {
//    
//    var body: some View {
//
//    }
//}

struct GameButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        GameButtonsView()
    }
}
