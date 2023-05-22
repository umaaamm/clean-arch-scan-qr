//
//  HistoryTransaksiViewController.swift
//  ScanQR
//
//  Created by Kurniawan Gigih Lutfi Umam on 11/05/23.
//

import Foundation
import UIKit
import RealmSwift

protocol HistoryTransaksiView: AnyObject {
    func startFetching()
    func showDataR(datas: [RealmEntity])
    func showErrorMessage(message: String)
}

public class HistoryTransaksiViewController: UIViewController {
    let realm = try! Realm()
    @IBOutlet weak var tableView: UITableView!
    var presenter: ScanQrPresenter?
    var dataFetch: [RealmEntity] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getDataRealm()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        // Do any additional setup after loading the view.
    }
}


extension HistoryTransaksiViewController: HistoryTransaksiView {
    func startFetching() {
        self.LoadingStart()
    }
    
    func showDataR(datas: [RealmEntity]) {
        self.LoadingStop()
        self.dataFetch = datas
    }
    
    func showErrorMessage(message: String) {
        self.showToast(message: message, font: .systemFont(ofSize: 12.0))
    }
    
    
}

extension HistoryTransaksiViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataFetch.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell
        else {
            return UITableViewCell()
        }
        cell.lblMerchanName.text = "Merchant : "+dataFetch[indexPath.row].MerchantName
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale(identifier: "id_ID")
        let formattedValue = currencyFormatter.string(from: dataFetch[indexPath.row].Nominal as NSNumber)
        
        cell.lblAmount.text = formattedValue
        return cell
    }
    
}

