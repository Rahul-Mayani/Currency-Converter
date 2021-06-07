//
//  BaseVC.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import UIKit
import RxSwift

class BaseVC: UIViewController {

    // MARK: - IBOutlet -
    @IBOutlet weak var screenTitleLabel : UILabel?
    
    @IBOutlet weak var errorLabel: UILabel?
        
    // MARK: - Variable -
    let rxbag = DisposeBag()
    
    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        setNeedsStatusBarAppearanceUpdate()
        
        modalPresentationStyle = .fullScreen
        
        view.tintAdjustmentMode = .normal
        
        screenTitleLabel?.text = title
        
        screenTitleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        screenTitleLabel?.textAlignment = .center
        screenTitleLabel?.textColor = UIColor.black
        
        errorLabel?.textColor = UIColor.gray
        errorLabel?.textAlignment = .center
        errorLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        errorLabel?.numberOfLines = 0
        
        errorLabel?.text = ""
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        view.endEditing(true)
        AppLoader.stopLoaderToAnimating()
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Memory Release -
    deinit {
        print("Memory Release : \(String(describing: self))\n" )
    }
}
