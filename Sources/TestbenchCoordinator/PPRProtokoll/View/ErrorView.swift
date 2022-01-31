//
//  ErrorView.swift
//  
//
//  Created by Simon Schöpke on 31.01.22.
//

import SwiftPDF


struct ErrorView: View {
    
    let description: String
    
    private let backgroundColor = Color(red: 0.99, green: 0.95, blue: 0.94)
    private let borderColor = Color(red: 0.97, green: 0.66, blue: 0.63)
    private let cornerRadius = 5.0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Error")
                    .fontSize(14)
                Text(description)
            }
            
            Spacer(minLength: 0)
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor)
        }
        .padding(1)
        .padding(.horizontal, 16)
    }
}
