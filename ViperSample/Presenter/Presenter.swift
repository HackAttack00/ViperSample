//
//  Presenter.swift
//  ViperSample
//
//  Created by Seungchul Lee on 2023/03/28.
//

import Foundation

protocol CandyPresenterProtocol : AnyObject {
    /// The presenter will fetch data from the Interactor thru implementing the Interactor fetch function.
    func fetchCandy()
    func update(candyQuantity candyquantity: Int)
    func interactor(_ interactor: CandyInteractorProtocol, didFetch object: CandyEntity) // 병합 성공
    func interactor(_ interactor: CandyInteractorProtocol, didFailWith error: Error) // 병합 실패
    func interactor(_ interactor: CandyInteractorProtocol, didUpdateTotalPrice totalPrice:Float, totalInclTax:Float,vat:Float, quantity:Int)
}

// Presenter는 View에서 사용할 데이터 변환과 UI 작업 가로채기 작업을 수행한다.

class CandyPresenter {

    weak var view: CandyViewProtocol?
    var interactor: CandyInteractorProtocol?
    var wireframe : RouterProtocol?
}

extension CandyPresenter : CandyPresenterProtocol {

    
    func fetchCandy() {
        interactor?.fetchCandy()
    }
    
    func update(candyQuantity candyquantity: Int) {
        interactor?.update(candyQuantity: candyquantity)
    }
    
    func interactor(_ interactor: CandyInteractorProtocol, didFetch object: CandyEntity) {
        let candyPriceText = "\(object.price) 원"
        let candyViewModel = CandyViewModel(title: object.title, description: object.description, price: candyPriceText, imageName: object.imageName)
        
        view?.set(viewModel: candyViewModel)
    }

    func interactor(_ interactor: CandyInteractorProtocol, didFailWith error: Error) {
        
    }
    
    func interactor(_ interactor: CandyInteractorProtocol, didUpdateTotalPrice totalPrice: Float, totalInclTax: Float, vat: Float, quantity: Int) {
        let totalPriceText = "Total Price : \(totalPrice)won"
        let totalInclTaxText = "Incl Tax : \(totalInclTax)won"
        let vatText = "Tax : \(vat)%"
        
        let totalPriceViewModel = TotalPriceViewModel(totalPrice: totalPriceText, totalInclTax: totalInclTaxText, vat: vatText, quantity: String(quantity))
        view?.set(totalPriceViewModel: totalPriceViewModel)
    }
}
