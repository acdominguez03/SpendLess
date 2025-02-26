//
//  Utils.swift
//  SpendLess
//
//  Created by Andres Cordón on 3/2/25.
//
import CryptoKit
import Foundation

class Utils {
    static let shared = Utils()
    
    private var key: SymmetricKey = SymmetricKey(data: Data(base64Encoded: "y9XK8Yr8zKgHtUp3qMv2X+9vjbS0GJDyUdrZtmzKNtE=")!)
    
    func encrypt(text: String) -> Data? {
        guard let data = text.data(using: .utf8) else { return nil }
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined
        } catch {
            print("❌ Error al encriptar: \(error)")
            return nil
        }
    }
    
    func encryptBool(value: Bool) -> Data? {
        let data = Data([value ? 0x01 : 0x00])
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined
        } catch {
            print("❌ Error al encriptar: \(error)")
            return nil
        }
    }

    func decrypt(data: Data) -> String? {
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("❌ Error al desencriptar: \(error)")
            return nil
        }
    }
    
    func decryptBool(data: Data) -> Bool? {
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return decryptedData[0] != 0
        } catch {
            print("❌ Error al desencriptar: \(error)")
            return nil
        }
    }
    
    func hashValue(value: String) -> String {
        let data = Data(value.utf8)
        let hashed = SHA256.hash(data: data)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    func dateToString(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: date)
    }
        
    func stringToDate(_ string: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: string)
    }
    
    func groupAndSortByDay(transactions: [TransactionModel]) -> [Dictionary<Date, [TransactionModel]>.Element] {
        let mappedTransactions = Dictionary(grouping: transactions) {
            Calendar.current.startOfDay(for: $0.date)
        }.sorted(by: {
            $0.key > $1.key
        })
        
        return mappedTransactions
    }
    
    func formatAmountDecimalSeparator(amount: String) -> Double {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.number(from: amount)?.doubleValue ?? 0.0
    }
    
    func formatTransactionAmount(
        transaction: TransactionModel,
        currency: Currency,
        decimalSeparator: DecimalSeparator,
        thousandSeparator: ThousandsSeparator,
        expensesFormat: ExpensesFormat
    ) -> String {
        
        let formattedNumber = formatNumberWithUserSettings(amount: transaction.amount, currency: currency, decimalSeparator: decimalSeparator, thousandSeparator: thousandSeparator)
        
        if transaction.category != nil {
            if expensesFormat == ExpensesFormat.less {
                return "-\(formattedNumber)"
            } else {
                return "(\(formattedNumber))"
            }
        }
        
        return formattedNumber
    }
    

    func formatNumberWithUserSettings(
        amount: Double,
        currency: Currency,
        decimalSeparator: DecimalSeparator,
        thousandSeparator: ThousandsSeparator,
        expensesFormat: ExpensesFormat? = nil
    ) -> String {
        let formatter = NumberFormatter()
        
        formatter.locale = Locale(identifier: "en_US")
        
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        formatter.decimalSeparator = decimalSeparator.rawValue
        formatter.groupingSeparator = thousandSeparator.rawValue
        
        formatter.numberStyle = .currency
        formatter.currencySymbol = currency.icon
        
        let formattedNumber = formatter.string(from: NSNumber(value: amount)) ?? ""
        
        if expensesFormat != nil {
            if expensesFormat == ExpensesFormat.less {
                return "-\(formattedNumber)"
            } else {
                return "(\(formattedNumber))"
            }
        }
        
        return formattedNumber
    }
    
    func checkIfTextIsOnlyLettersAndNumber(_ texto: String) -> Bool {
        let regex = "^[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ ]+$"
        return texto.range(of: regex, options: .regularExpression) != nil
    }
}


