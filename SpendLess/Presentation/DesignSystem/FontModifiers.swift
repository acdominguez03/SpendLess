//
//  FontModifiers.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//

import SwiftUI


struct DisplayLarge: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 45))
            .lineSpacing(52)
            .foregroundStyle(.black)
    }
}

struct DisplayMedium: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 36))
            .lineSpacing(44)
            .foregroundStyle(.black)
    }
}

struct HeadlineLarge: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 32))
            .lineSpacing(40)
            .foregroundStyle(.black)
    }
}

struct HeadlineMedium: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 28))
            .lineSpacing(34)
            .foregroundStyle(.black)
    }
}


struct TitleLarge: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 20))
            .lineSpacing(26)
            .foregroundStyle(.black)
    }
}

struct TitleMedium: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-SemiBold", size: 16))
            .lineSpacing(24)
            .foregroundStyle(.black)
    }
}

struct TitleSmall: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Medium", size: 14))
            .lineSpacing(20)
            .foregroundStyle(.black)
    }
}

struct LabelMedium: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Medium", size: 16))
            .lineSpacing(24)
            .foregroundStyle(.black)
    }
}

struct LabelSmall: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Medium", size: 14))
            .lineSpacing(20)
            .foregroundStyle(.black)
    }
}

struct BodyMedium: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Regular", size: 16))
            .lineSpacing(24)
            .foregroundStyle(.black)
    }
}

struct BodySmall: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Regular", size: 14))
            .lineSpacing(20)
            .foregroundStyle(.black)
    }
}

struct BodyXSmall: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Figtree-Regular", size: 12))
            .lineSpacing(16)
            .foregroundStyle(.black)
    }
}
