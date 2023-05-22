//
//  ScanQrUseCase.swift
//  ScanQR
//
//  Created by Kurniawan Gigih Lutfi Umam on 11/05/23.
//

import Foundation
import RealmSwift

protocol ScanQrUseCase {
    func saveDataRealm(datas: RealmEntity)
    func saveInitsaldo()
    func getDataRealm(completion: @escaping (Result<[RealmEntity], RealmError>) -> ())
}

class ScanQrUseCaseImpl: ScanQrUseCase {
    let realm = try! Realm()
    
    func saveDataRealm(datas: RealmEntity) {
        let data = DataModel()
        data.MerchantName = datas.MerchantName
        data.Nominal = datas.Nominal
       
        //update Saldo
        let dataSaldo = realm.objects(DataModelSaldo.self).first!

        try! realm.write {
            realm.add(data)
            dataSaldo.Saldo = dataSaldo.Saldo - data.Nominal
        }
    }
    
    func saveInitsaldo(){
        let data = DataModelSaldo()
        data.Saldo = 10000000
        try! realm.write {
            realm.add(data)
        }
    }
    
    func getDataRealm(completion: @escaping (Result<[RealmEntity], RealmError>) -> ()) {
        var dataArray: [RealmEntity] = []
        let dataM = realm.objects(DataModel.self)
        dataArray = dataM.lazy.compactMap { hasil in
            return RealmEntity(Nominal: hasil.Nominal, MerchantName: hasil.MerchantName)
        }
        completion(.success(dataArray))
    }
}
