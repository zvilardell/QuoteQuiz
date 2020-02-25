//
//  ResultsView.swift
//  QuoteQuiz
//
//  Created by Zach Vilardell on 2/18/20.
//  Copyright © 2020 zvilardell. All rights reserved.
//

import SwiftUI

enum ImageName: String {
    case favorited = "suit.heart.fill"
    case notFavorited = "suit.heart"
    case nextArrow = "arrow.right"
}

struct ResultsView: View {
    
    var body: some View {
        ZStack {
            //set background color
            Color.black
            .edgesIgnoringSafeArea(.all)
            
            //results view
            VStack {
                Text("Hello")
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    ResultsButton(imageName: .notFavorited, color: Color(red: 255 / 255, green: 111 / 255, blue: 108 / 255))
                    Divider()
                    ResultsButton(imageName: .nextArrow, color: Color(red: 174 / 255, green: 255 / 255, blue: 157 / 255))
                }
            }
        }
    }
}

struct ResultsButton: View {
    
    let imageName: ImageName
    let color: Color
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        //navigation link only working once in preview/simulator due to Xcode bug
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: imageName.rawValue)
                .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 0.0, maxHeight: .infinity)
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(.white)
        }
        .background(color)
        .cornerRadius(5)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
