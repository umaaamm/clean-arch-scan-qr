//
//  PembayaranBerhasilViewController.swift
//  ScanQR
//
//  Created by Kurniawan Gigih Lutfi Umam on 11/05/23.
//

import Foundation
import UIKit

class PembayaranBerhasilViewController: UIViewController {
    
    @IBAction func btnGoHome(_ sender: Any) {
        self.navigationController?.popToViewController(of: ViewController.self, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)

        // Do any additional setup after loading the view.
    }
}
