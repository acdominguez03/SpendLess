//
//  FontModifiers.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//

import SwiftUI


struct DisplayLarge: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 45))
            .foregroundStyle(color)
    }
}

struct DisplayMedium: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 36))
            .foregroundStyle(color)
    }
}

struct HeadlineLarge: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 32))
            .foregroundStyle(color)
    }
}

struct HeadlineMedium: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 28))
            .foregroundStyle(color)
    }
}


struct TitleLarge: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 20))
            .foregroundStyle(color)
    }
}

struct TitleMedium: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 16))
            .foregroundStyle(color)
    }
}

struct TitleSmall: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Medium", size: 14))
            .foregroundStyle(color)
    }
}

struct LabelMedium: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Medium", size: 16))
            .foregroundStyle(color)
    }
}

struct LabelSmall: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Medium", size: 14))
            .foregroundStyle(color)
    }
}

struct BodyMedium: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Regular", size: 16))
            .foregroundStyle(color)
    }
}

struct BodySmall: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Regular", size: 14))
            .foregroundStyle(color)
    }
}

struct BodyXSmall: ViewModifier {
    var color: Color = Color.black
    
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Regular", size: 12))
            .foregroundStyle(color)
    }
}
