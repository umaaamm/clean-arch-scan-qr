//
//  DataModel.swift
//  ScanQR
//
//  Created by Kurniawan Gigih Lutfi Umam on 11/05/23.
//

import Foundation
import RealmSwift

class DataModel: Object {
    @Persisted var Nominal = 0
    @Persisted var MerchantName = ""
}
