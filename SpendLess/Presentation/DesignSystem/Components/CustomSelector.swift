//
//  CustomSelector.swift
//  SpendLess
//
//  Created by Andres Cordón on 7/2/25.
//

import SwiftUI

struct CustomSelector: View {
    @Binding var valueSelected: String
    
    let title: String
    var values: [String] = ["-$10", "($10)"]
    var onValueSelectorClicked: (String) -> Void = {_ in}
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .modifier(LabelSmall(color: Color("OnSurface")))
                .padding(.top, 16)
                .padding(.bottom, 4)
            
            HStack(spacing: 0) {
                ForEach(values, id: \.self) { value in
                    ZStack {
                        Rectangle()
                            .fill(Color("PrimaryContainer").opacity(0.08))
                        
                        Rectangle()
                            .fill(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding(4)
                            .opacity(valueSelected == value ? 1 : 0.01)
                            .onTapGesture {
                                withAnimation(.interactiveSpring()) {
                                    valueSelected = value
                                    onValueSelectorClicked(value)
                                }
                            }
                    }.overlay {
                        Text(value)
                            .modifier(TitleMedium(color: valueSelected == value ? Color("OnSurface") : Color("OnPrimaryFixed")))
                    }
                }
            }
            .frame(height: 48)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .onAppear {
                valueSelected = values[0]
            }
        }
    }
}

#Preview {
    CustomSelector(valueSelected: .constant(""), title: "Expenses Format")
}
