//
//  RealmEntity.swift
//  ScanQR
//
//  Created by Kurniawan Gigih Lutfi Umam on 11/05/23.
//

import Foundation

struct RealmEntity {
    let Nominal: Int
    let MerchantName: String
    
    init(Nominal: Int,MerchantName: String) {
        self.Nominal = Nominal
        self.MerchantName = MerchantName
    }
}
