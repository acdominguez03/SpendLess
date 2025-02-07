//
//  DropdownMenuItemView.swift
//  SpendLess
//
//  Created by Andres Cordón on 7/2/25.
//

import SwiftUI

struct DropdownMenuItemView: View {
    
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
                Text(item.icon)
                    .modifier(LabelMedium(color: Color("OnSurface")))
                    .padding(.leading, 16)
                
                Text(item.title)
                    .modifier(BodyMedium(color: Color("OnSurfaceVariant")))
                
                Spacer()
                
                Image("Checkmark")
                    .padding(.trailing, 12)
                    .opacity(selectionId == item.id ? 1 : 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 12)
        }

    }
}

#Preview {
    DropdownMenuItemView(isExpanded: .constant(true), selectionTitle: .constant(Currency.dollar.name), selectionIcon: .constant(Currency.dollar.icon), selectionId: .constant(0), item: DropdownItem(id: 0, title: Currency.dollar.name, icon: Currency.dollar.icon, onSelect: {_ in }))
}
