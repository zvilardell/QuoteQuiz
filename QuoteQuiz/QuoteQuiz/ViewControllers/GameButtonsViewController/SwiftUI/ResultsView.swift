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
        VStack {
            Text("Hello")
            Spacer()
            HStack {
                ResultsButton(imageName: .notFavorited, color: Color(red: 255 / 255, green: 111 / 255, blue: 108 / 255))
                Divider()
                ResultsButton(imageName: .nextArrow, color: Color(red: 174 / 255, green: 255 / 255, blue: 157 / 255))
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
            print("zzz hello")
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: imageName.rawValue)
                .foregroundColor(Color.white)
        }
        .frame(minWidth: 0.0, maxWidth: .infinity, minHeight: 200.0, maxHeight: 200.0)
        .background(color)
        .cornerRadius(5)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
