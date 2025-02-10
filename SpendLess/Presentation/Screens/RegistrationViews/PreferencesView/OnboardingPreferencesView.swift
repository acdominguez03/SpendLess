//
//  PreferencesView.swift
//  SpendLess
//
//  Created by Andres Cordón on 5/2/25.
//

import SwiftUI
import SwiftData

struct OnboardingPreferencesView: View {
    @Binding var path: [Screen]
    
    @State var viewModel: OnboardingPreferencesViewModel = OnboardingPreferencesViewModel()
    
    var exampleFormatting = ""
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                ZStack(alignment: .top) {
                    BackButton {
                        viewModel.onBackButtonPressed()
                    }
                }
                
                CustomSpacer(height: 72)
                
                VStack(alignment: .leading) {
                    Text("Set SpendLess\nto your preferences")
                        .modifier(HeadlineMedium())
                        .multilineTextAlignment(.leading)
                    
                    CustomSpacer(height: 8)
                    
                    Text("You can change it at any time in Settings")
                        .modifier(BodyMedium(color: Color("OnSurfaceVariant")))
                    
                    CustomSpacer(height: 24)
                    
                    VStack(alignment: .center, spacing: 2) {
                        Text(viewModel.exampleText)
                            .modifier(HeadlineLarge())
                        
                        Text("spend this month")
                            .modifier(BodySmall(color: Color("OnSurfaceVariant")))
                    }
                    .frame(maxWidth: .infinity)
                    .padding(24)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 16)
                    
                    VStack(alignment: .leading) {
                        
                        CustomSelector(
                            valueSelected: .constant(viewModel.expensesFormat.getExpenseExample(currencyIcon: viewModel.currency.icon)),
                            title: "Expenses format",
                            values: viewModel.expensesFormatValue,
                            onValueSelectorClicked: { value in
                                viewModel.changeExpensesFormatValue(value: value)
                            }
                        )
                        
                        Text("Currency")
                            .modifier(LabelSmall(color: Color("OnSurface")))
                            .padding(.top, 16)
                            .padding(.bottom, 4)
                        
                        CustomDropdownMenu(
                            selectionTitle: Currency.euro.name,
                            selectionIcon: Currency.euro.icon,
                            items: Currency.allCases.map({ currency in
                                DropdownItem(
                                    id: currency.rawValue,
                                    title: currency.name,
                                    icon: currency.icon,
                                    onSelect: { id in
                                        viewModel.changeCurrencyValue(id: id)
                                    }
                                )
                            }),
                            customDropdownMenuType: CustomDropdownMenuTypes.currency
                        )
                        .zIndex(10)
                        
                        CustomSelector(
                            valueSelected: .constant(viewModel.decimalSeparator.example),
                            title: "Decimal separator",
                            values: DecimalSeparator.allCases.map { $0.example },
                            onValueSelectorClicked: { value in
                                viewModel.changeDecimalSeparatorValue(value: value)
                            }
                        )
                        .padding(.top, 38)
                        
                        CustomSelector(
                            valueSelected: .constant(viewModel.thousandsSeparator.example),
                            title: "Thousands separator",
                            values: ThousandsSeparator.allCases.map{ $0.example },
                            onValueSelectorClicked: { value in
                                viewModel.changeThousandsSeparatorValue(value: value)
                            }
                        )
                        
                        CustomSpacer(height: 34)
                        
                        CustomButton(
                            text: "Start Tracking!",
                            isDisabled: viewModel.buttonDisabled,
                            onClick: {
                                Task {
                                    await viewModel.onSaveButtonClicked()
                                }
                            }
                        )
                            
                    }
                    
                }.padding(.horizontal, 16)
                
                Spacer()
            }
            .background(Color("Background"))
            .navigationBarBackButtonHidden()
            .onAppear {
                viewModel.path = $path
            }
            .zIndex(1)
        }
    }
}

#Preview {
    OnboardingPreferencesView(path: .constant([]))
}
