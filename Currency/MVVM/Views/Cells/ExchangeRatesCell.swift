//
//  ExchangeRatesCell.swift
//  Currency
//
//  Created by Rahul Mayani on 31/05/21.
//

import UIKit

class ExchangeRatesCell: UICollectionViewCell {
    
    // MARK: - IBOutlet -
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    // MARK: - Variable -
    var data: CurrencyQuote? = nil {
        didSet {
            guard let quote = data else { return }
            currencyLabel.text = quote.name
            amountLabel.text = quote.value.currencyAmount()
        }
    }
    
    // MARK: - Cell Life Cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
