//
//  PinKeyboard.swift
//  SpendLess
//
//  Created by Andres Cordón on 5/2/25.
//

import SwiftUI

struct PinKeyboard: View {
    
    let numbers = (0...11)
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var onClickNumberButton: (String) -> Void = {_ in }
    var onClickDeleteButton: () -> Void = {}
    
    var pin: String = ""
    
    var body: some View {
        HStack {
            ForEach(0..<5) { i in
                Circle()
                    .fill(pin.count > i ? Color("PrimaryApp") : Color("OnBackground"))
                    .frame(width: 16, height: 16)
                    .opacity(pin.count > i ? 1 : 0.12)
            }
        }
        
        Spacer().frame(height: 32)
        
        LazyVGrid(columns: columns, spacing: 4) {
            ForEach(numbers, id: \.self) { number in
                if number == 9 {
                    Color.clear
                } else if number < 9 {
                    NumberButton(
                        number: String(number),
                        onClick: {
                            onClickNumberButton(String(number))
                        }
                    )
                } else if (number == 10) {
                    NumberButton(
                        number: "0",
                        onClick: {
                            onClickNumberButton("0")
                        }
                    )
                } else if (number == 11) {
                    DeleteButton(onClick: {
                        onClickDeleteButton()
                    })
                }
            }
        }.padding(.horizontal, 40)
    }
}

#Preview {
    PinKeyboard()
}
