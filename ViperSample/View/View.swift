//
//  View.swift
//  ViperSample
//
//  Created by Seungchul Lee on 2023/03/28.
//

import Foundation
import UIKit

protocol CandyViewProtocol: AnyObject {
    var presenter: CandyPresenterProtocol? { get set }
    func set(viewModel: CandyViewModel) // Set the view Object of Type CandyEntity
    func set(totalPriceViewModel viewModel: TotalPriceViewModel) // Set the view price object
}

class CandyViewController: UIViewController {

    var presenter: CandyPresenterProtocol?
    
    @IBOutlet weak private var candyImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var quantityStepper: UIStepper!
    @IBOutlet weak private var quantityLabel: UILabel!
    
    @IBOutlet weak private var totalPriceLabel: UILabel!
    @IBOutlet weak private var taxLabel: UILabel!
    @IBOutlet weak private var inclTaxLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchCandy()
    }
    
    @IBAction func quantityStepperValueChanged(_ sender: Any) {
        presenter?.update(candyQuantity: Int(quantityStepper!.value))
    }
}

extension CandyViewController: CandyViewProtocol {
   func set(viewModel: CandyViewModel) {

       titleLabel.text = viewModel.title
       descriptionLabel.text = viewModel.description
       priceLabel.text = viewModel.price

       candyImageView.image = UIImage(named: viewModel.imageName)
   }
   
   func set(totalPriceViewModel viewModel: TotalPriceViewModel) {
       //excl tax, incl tax, VAT
       quantityLabel.text = viewModel.quantity
       totalPriceLabel.text = viewModel.totalPrice
       taxLabel.text = viewModel.vat
       inclTaxLabel.text = viewModel.totalInclTax
   }

}
