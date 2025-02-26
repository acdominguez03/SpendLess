//
//  MostPopularCategoryView.swift
//  SpendLess
//
//  Created by Andres Cordón on 20/2/25.
//

import SwiftUI

struct CategoryWithTheHighestSpendingView: View {
    @Binding var category: Categories
    
    var body: some View {
        HStack(alignment: .center) {
            Image(category.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(13)
                .background(Color("PrimaryFixed"))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.leading, 8)
                .padding(.vertical, 8)
            
            VStack(alignment: .leading) {
                Text(category.rawValue)
                    .modifier(TitleLarge(color: Color("OnPrimary")))
                
                Text("Most popular category")
                    .modifier(BodyXSmall(color: Color("OnPrimary").opacity(0.7)))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.horizontal, 16)
    }
}

#Preview {
    CategoryWithTheHighestSpendingView(category: .constant(Categories.other))
}
