//
//  BackgroundModifier.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//

import SwiftUI

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .containerRelativeFrame([.horizontal, .vertical])
            .background(Color("Background"))
    }
}
