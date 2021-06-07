//
//  CurrencyVC.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import UIKit

class CurrencyVC: BaseVC {

    // MARK: - IBOutlet -
    @IBOutlet weak var amountTextField: CurrencyTextField!
    @IBOutlet weak var currencyPickerTextField: UITextField!
    
    @IBOutlet weak var exchangeRatesCollectionView: UICollectionView!
        
    // MARK: - Variable -
    private let currencyVM = CurrencyVM()
    
    private var selectedIndexOfCurrencyPicker = -1
    
    // MARK: - View Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPickerTextField.rightView(image: #imageLiteral(resourceName: "ic_drop_down"), width: 25.0)
                
        setCollectionViewData()
        
        currencyPickerTextField.text = defaultCurrency
        
        /// Get the Currency details from the server
        currencyVM.getDataFromServer(true, isGetAllCurrency: true)
    }
}

// MARK: - Currency Picker View -
extension CurrencyVC {
    
    private func openCurrencyPickerView() {
        
        if currencyVM.allCurrencyArray.count == 0 { return }
        
        if selectedIndexOfCurrencyPicker == -1 {
            selectedIndexOfCurrencyPicker = currencyVM.allCurrencyArray.firstIndex(of: defaultCurrency) ?? 0
        }
        
        StringPickerPopover(title: AppMessages.currencyPickerTitle, choices: currencyVM.allCurrencyArray)
            .setSelectedRow(selectedIndexOfCurrencyPicker)
            .setDoneButton(action: { [weak self] (popover, selectedRow, selectedString) in
                self?.currencyPickerTextField.text = selectedString
                self?.selectedIndexOfCurrencyPicker = selectedRow
                /// refresh exchange rate
                self?.currencyVM.refreshExchangeRate(currency: self?.currencyPickerTextField.text ?? defaultCurrency)
            })
            .appear(originView: currencyPickerTextField, baseViewController: self)
    }
}

// MARK: - Collection View -
extension CurrencyVC {
    
    private func setCollectionViewData() {
        currencyVM.currencyExchangeRatesArray.bind(to: exchangeRatesCollectionView.rx.items(cellIdentifier: String(describing: ExchangeRatesCell.self), cellType: ExchangeRatesCell.self)) {  [weak self] (row, exchangeRate, cell) in
            cell.data = self?.currencyVM.currencyQuote(exchangeRate, amount: Double(self?.amountTextField.text ?? "\(defaultAmount)") ?? defaultAmount , currency: self?.currencyPickerTextField.text ?? defaultCurrency)
        } => rxbag
    }
}

// MARK: - TextField -
extension CurrencyVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if Double(textField.text ?? "0.0") != 0.0 {
            /// refresh exchange rate
            currencyVM.refreshExchangeRate(currency: currencyPickerTextField.text ?? defaultCurrency)
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if amountTextField == textField {
            return true
        }
        /// For Currency Picker TextField
        openCurrencyPickerView()
        return false
    }
}
