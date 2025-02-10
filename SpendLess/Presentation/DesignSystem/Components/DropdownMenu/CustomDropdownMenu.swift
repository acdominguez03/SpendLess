//
//  CustomDropdownMenu.swift
//  SpendLess
//
//  Created by Andres Cordón on 7/2/25.
//

import SwiftUI

enum CustomDropdownMenuTypes {
    case currency
    case categories
}

struct CustomDropdownMenu: View {
    @State private var isExpanded = false
    @State var selectionTitle = Categories.clothing.rawValue
    @State var selectionIcon = Categories.clothing.icon
    @State var selectedRowId = 0
    let items: [DropdownItem]
    let customDropdownMenuType: CustomDropdownMenuTypes
    
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 4) {
                HStack{
                    if (customDropdownMenuType == CustomDropdownMenuTypes.currency) {
                        Text(selectionIcon)
                            .modifier(LabelMedium(color: Color("OnSurface")))
                            .padding(.leading, 16)
                            .padding(.vertical, 12)
                        
                        Text(selectionTitle)
                            .modifier(BodyMedium(color: Color("OnSurfaceVariant")))
                    } else {
                        CategoryDropdownCell(icon: selectionIcon, title: selectionTitle)
                    }
                    
                    Spacer()
                    
                    Image("TriangleBottom")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .padding(.trailing, 19)
                    
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 6)
                .onTapGesture {
                    isExpanded.toggle()
                }
                .onAppear {
                    self.selectedRowId = 1
                }
                .animation(.easeInOut(duration: 0.3), value: isExpanded)
                
                if isExpanded {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.white)
                            .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 6)
                        
                        ScrollView {
                            VStack(spacing: 0) {
                                dropDownItemsList()
                            }
                            .shadow(color: Color("Shadow"), radius: 20, x: 0, y: 6)
                        }
                    }
                    .frame(maxHeight: 240)
                    .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
    
    private func dropDownItemsList() -> some View {
        ForEach(items) { item in
            if customDropdownMenuType == CustomDropdownMenuTypes.currency {
                DropdownMenuItemView(
                    isExpanded: $isExpanded,
                    selectionTitle: $selectionTitle,
                    selectionIcon: $selectionIcon,
                    selectionId: $selectedRowId,
                    item: item
                )
            } else {
                CategoryDropdownMenuItem(
                    isExpanded: $isExpanded,
                    selectionTitle: $selectionTitle,
                    selectionIcon: $selectionIcon,
                    selectionId: $selectedRowId,
                    item: item
                )
            }
            
        }
    }
}

#Preview {
    CustomDropdownMenu(items: [
        .init(id: Currency.dollar.rawValue, title: Currency.dollar.name, icon: Currency.dollar.icon, onSelect: {_ in })
    ], customDropdownMenuType: CustomDropdownMenuTypes.categories)
}
