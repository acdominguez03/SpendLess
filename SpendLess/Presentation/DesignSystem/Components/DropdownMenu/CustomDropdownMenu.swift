//
//  CustomDropdownMenu.swift
//  SpendLess
//
//  Created by Andres Cordón on 7/2/25.
//

import SwiftUI

struct CustomDropdownMenu: View {
    @State private var isExpanded = false
    @State var selectionTitle = "Euro (EUR)"
    @State var selectionIcon = "$"
    @State var selectedRowId = 0
    let items: [DropdownItem]
    
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 4) {
                HStack{
                    Text(selectionIcon)
                        .modifier(LabelMedium(color: Color("OnSurface")))
                        .padding(.leading, 16)
                    
                    Text(selectionTitle)
                        .modifier(BodyMedium(color: Color("OnSurfaceVariant")))
                    
                    Spacer()
                    
                    Image("TriangleBottom")
                        .rotationEffect(.degrees(isExpanded ? 180 : 0))
                        .padding(.trailing, 19)
                    
                }
                .padding(.vertical, 12)
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
                    }.fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }
    
    private func dropDownItemsList() -> some View {
        ForEach(items) { item in
            DropdownMenuItemView(
                isExpanded: $isExpanded,
                selectionTitle: $selectionTitle,
                selectionIcon: $selectionIcon,
                selectionId: $selectedRowId,
                item: item
            )
        }
    }
}

#Preview {
    CustomDropdownMenu(items: [
        .init(id: Currency.dollar.rawValue, title: Currency.dollar.name, icon: Currency.dollar.icon, onSelect: {_ in })
    ])
}
