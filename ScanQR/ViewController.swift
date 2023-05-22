//
//  ViewController.swift
//  ScanQR
//
//  Created by Kurniawan Gigih Lutfi Umam on 11/05/23.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    let realm = try! Realm()
    var presenter: ScanQrPresenter?
    @IBOutlet weak var lblSaldo: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        callDataRealm()
    }
    
    func callDataRealm(){
        let usecase: ScanQrUseCase = ScanQrUseCaseImpl()
        let presenter: ScanQrPresenter = ScanQrPresenterImpl(usecase: usecase)
                
        let dataSaldo = realm.objects(DataModelSaldo.self)
        
        if dataSaldo.count == 0 {
            presenter.saveDataSaldo()
        }
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "id_ID")
        let formattedValue = currencyFormatter.string(from: dataSaldo[0].Saldo as NSNumber)
        lblSaldo.text = formattedValue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        callDataRealm()
    }
    
    @IBAction func btnTappedHistory(_ sender: Any) {
        let vc = HistoryTransaksiViewController(nibName: "HistoryTransaksiView", bundle: nil)
        let usecase: ScanQrUseCase = ScanQrUseCaseImpl()
        let presenter: ScanQrPresenter = ScanQrPresenterImpl(usecase: usecase)
        presenter.view = vc
        vc.presenter = presenter
        vc.title = "History Transaksi"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func btnTappedInside(_ sender: Any) {
        let vc = ScanQRViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
}

