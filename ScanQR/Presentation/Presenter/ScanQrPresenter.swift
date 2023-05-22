//
//  ScanQrPresenter.swift
//  ScanQR
//
//  Created by Kurniawan Gigih Lutfi Umam on 11/05/23.
//

import Foundation
import RealmSwift

protocol ScanQrPresenter: AnyObject {
    func saveDataPresenter(data: RealmEntity)
    func saveDataSaldo()
    func getDataRealm()
    var  view: HistoryTransaksiView? {get set}
}

class ScanQrPresenterImpl: ScanQrPresenter {
    private let usecase: ScanQrUseCase
   weak var view: HistoryTransaksiView?

    init(usecase: ScanQrUseCase) {
        self.usecase = usecase
    }

    func saveDataPresenter(data: RealmEntity) {
        usecase.saveDataRealm(datas: data)
    }
    
    func saveDataSaldo() {
        usecase.saveInitsaldo()
    }
    
    func getDataRealm() {
        view?.startFetching()
        usecase.getDataRealm() { [weak self] result in
            switch result {
            case .success(let dataR):
                self?.view?.showDataR(datas: dataR)
            case .failure(_):
                self?.view?.showErrorMessage(message: "Gagal Mengambil Data.")
            }
        }
    }
    
}
