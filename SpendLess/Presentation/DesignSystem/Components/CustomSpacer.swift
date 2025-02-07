//
//  CustomSpacer.swift
//  SpendLess
//
//  Created by Andres Cordón on 6/2/25.
//

import SwiftUI

struct CustomSpacer: View {
    var height: CGFloat
    
    var body: some View {
        Spacer().frame(height: height)
    }
}

#Preview {
    CustomSpacer(height: 8)
}
