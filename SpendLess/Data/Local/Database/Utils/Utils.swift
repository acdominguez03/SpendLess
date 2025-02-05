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
    
    private var key: SymmetricKey = SymmetricKey(size: .bits256)
    
    func encrypt(text: String) -> Data? {
        guard let data = text.data(using: .utf8) else { return nil }
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined
        } catch {
            print("Error al encriptar: \(error)")
            return nil
        }
    }
    
    func decrypt(data: Data) -> String? {
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Error al desencriptar: \(error)")
            return nil
        }
    }
    
    func dateToString(_ date: Date) -> String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: date)
    }
        
    func stringToDate(_ string: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: string)
    }
}
