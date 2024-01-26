//
//  HeaderView.swift
//  Buckets
//
//  Created by Romell Bolton on 1/26/24.
//  Copyright © 2024 Romell Bolton. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    let text: String
    var body: some View {
        VStack {
            HStack {
                Image("AppIcon2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 60)
                Text(text)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.leading, 8)
                Spacer()
            }
            .padding()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static let text = "Test string"
    static var previews: some View {
        HeaderView(text: text)
    }
}
