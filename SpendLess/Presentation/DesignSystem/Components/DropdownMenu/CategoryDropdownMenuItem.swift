//
//  CategoryDropdownMenuItem.swift
//  SpendLess
//
//  Created by Andres Cordón on 12/2/25.
//

import SwiftUI

struct CategoryDropdownMenuItem: View {
    @Binding var isExpanded: Bool
    @Binding var selectionTitle: String
    @Binding var selectionIcon: String
    @Binding var selectionId: Int
    
    let item: DropdownItem
    
    var body: some View {
        Button {
            isExpanded = false
            selectionTitle = item.title
            selectionIcon = item.icon
            selectionId = item.id
            item.onSelect(selectionId)
        } label: {
            HStack {
                CategoryDropdownCell(icon: item.icon, title: item.title)
                
                Spacer()
                
                Image("CheckMark")
                    .padding(.trailing, 12)
                    .opacity(selectionId == item.id ? 1 : 0)
            }
        }
    }
}

struct CategoryDropdownCell: View {
    let icon: String
    let title: String
    
    var body: some View {
        Image(icon)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .padding(10)
            .background(Color("PrimaryFixed"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.vertical, 4)
            .padding(.leading, 4)
            .padding(.trailing, 8)
        
        Text(title)
            .modifier(LabelMedium(color: Color("OnSurface")))
    }
}

#Preview {
    CategoryDropdownMenuItem(
        isExpanded: .constant(true),
        selectionTitle: .constant(Categories.clothing.rawValue),
        selectionIcon: .constant(Categories.clothing.icon),
        selectionId: .constant(0),
        item: DropdownItem(id: 0, title: Categories.clothing.rawValue, icon: Categories.clothing.icon, onSelect: {_ in })
    )
}
