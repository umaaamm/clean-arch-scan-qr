//
//  ScanQrUseCaseTest.swift
//  ScanQRTests
//
//  Created by Kurniawan Gigih Lutfi Umam on 12/05/23.
//

import XCTest
@testable import ScanQR
import RealmSwift

final class ScanQrUseCaseTest: XCTestCase {
    var sut: ScanQrUseCaseImpl!
    var fetchRealmMock: ScanQrFetcherMock!
    
    override func setUpWithError() throws {
        fetchRealmMock = ScanQrFetcherMock()
        sut = ScanQrUseCaseImpl()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetData() throws {
        // Given
        let scanFetch: RealmEntity =
        RealmEntity(Nominal: 1000, MerchantName: "Bank BNI"
        )
                
        fetchRealmMock.fetchDataQrStub = .success([scanFetch])
        
        // When
        var actualResult: Result<[RealmEntity], RealmError>!
        
        fetchRealmMock.fetchQrRealm() { result in
            actualResult = result
        }
                
        // Then
        switch actualResult {
        case .success(let success):
            XCTAssertEqual(success[0].Nominal, scanFetch.Nominal)
            XCTAssertEqual(success[0].MerchantName, scanFetch.MerchantName)
        case .failure(_):
            assertionFailure("get realm return failure")
        case .none:
            assertionFailure("get scanFetch return .none")
        }
    }
    
    func testSaveData() throws {
        let scanFetch: RealmEntity =
        RealmEntity(Nominal: 1000, MerchantName: "Bank BNI")
        fetchRealmMock.saveDataRealm(datas: scanFetch)
        
        XCTAssertTrue(fetchRealmMock.saveDataQrWasCalled)
    }
}


class ScanQrFetcherMock {
    var fetchDataQrStub: Result<[RealmEntity], RealmError>!
    var fetchDataQrWasCalled: Bool!
    func fetchQrRealm(completion: @escaping (Result<[RealmEntity], RealmError>) -> ()) {
        fetchDataQrWasCalled = true
        completion(fetchDataQrStub)
    }
    var saveDataQrWasCalled: Bool!
    func saveDataRealm(datas: RealmEntity){
        let realm = try! Realm()
        let data = DataModel()
        data.MerchantName = datas.MerchantName
        data.Nominal = datas.Nominal
       
        //update Saldo
        let dataSaldo = realm.objects(DataModelSaldo.self).first!

        try! realm.write {
            realm.add(data)
            dataSaldo.Saldo = dataSaldo.Saldo - data.Nominal
            saveDataQrWasCalled = true
        }
        
    }
}
