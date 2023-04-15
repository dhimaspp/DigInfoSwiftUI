//
//  TabButton.swift
//  DigInfo
//
//  Created by Dhimas P Pangestu on 09/04/23.
//
import SwiftUI

struct TabButton: View {
    let imageName: String
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            VStack(spacing: 5) {
                Image(systemName: imageName)
                    .font(.title)
                    .foregroundColor(isSelected ? Color.blue : Color.gray)
                Text(text)
                    .font(.footnote)
                    .foregroundColor(isSelected ? Color.blue : Color.gray)
            }
        })
    }
}
