//
//  QrEntity.swift
//  ScanQR
//
//  Created by Kurniawan Gigih Lutfi Umam on 11/05/23.
//

import Foundation

struct QrEntity {
    let bankName: String
    let amount: String
    let idTransaksi: String
    let namaMerchant: String
    
    init(bankName: String,amount: String, idTransaksi: String, namaMerchant: String) {
        self.bankName = bankName
        self.amount = amount
        self.idTransaksi = idTransaksi
        self.namaMerchant = namaMerchant
    }
}
