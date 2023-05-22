//
//  DetailTransaksiViewController.swift
//  ScanQR
//
//  Created by Kurniawan Gigih Lutfi Umam on 11/05/23.
//

import Foundation
import UIKit

protocol DetailTransaksi: AnyObject {
    func saveDataQr()
    func showError(message: String)
}

class DetailTransaksiViewController: UIViewController {
    var qrData: QrEntity?
    var presenter: ScanQrPresenter?
    
    @IBAction func btnBayar(_ sender: Any) {
        presenter?.saveDataPresenter(data: RealmEntity(Nominal: Int(qrData?.amount ?? "0") ?? 0, MerchantName: qrData?.namaMerchant ?? ""))
        
        let vc = PembayaranBerhasilViewController(nibName: "PembayaranBerhasilView", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBOutlet weak var lblMerchantName: UILabel!
    @IBOutlet weak var lblBankName: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblIdTransaksi: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblBankName.text = "Nama Bank : " + (qrData?.bankName ?? "")
        lblAmount.text = "Amount : " + (qrData?.amount ?? "")
        lblIdTransaksi.text = "ID Transaksi : " + (qrData?.idTransaksi ?? "")
        lblMerchantName.text = "Nama Merchant : " + (qrData?.namaMerchant ?? "")
    }
    
    func showData(qr: QrEntity) {
        self.qrData = qr
        
    }
}

extension DetailTransaksiViewController: DetailTransaksi {
    func saveDataQr() {
        self.LoadingStart()
    }
    
    func showError(message: String) {
        self.showToast(message: message, font: .systemFont(ofSize: 12.0))
    }
    
    
}
