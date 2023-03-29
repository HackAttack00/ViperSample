//
//  Interactor.swift
//  ViperSample
//
//  Created by Seungchul Lee on 2023/03/28.
//

import Foundation



protocol CandyInteractorProtocol {
    func fetchCandy()
    func update(candyQuantity quantity:Int)
}

// Interactor의 안에 비즈니스 로직이 있어야한다.
// 네트워크 호출이나 데이터베이스 쿼리 등 데이터 수집 작업을 이곳에서 진행한다.

class CandyInteractor: CandyInteractorProtocol {
    
    private static let vat:Float = 6.5 // 세금 값이니 신경쓰지 않아도 된다.
    private var candyEntity:CandyEntity?
    private let apiWorker: CandyAPIWorkerProtocol
    var presenter : CandyPresenterProtocol?
    
    required init(withApiWorker apiWorker:CandyAPIWorkerProtocol) {
        self.apiWorker = apiWorker
    }
    
    func fetchCandy() {
    // unowned는 값이 있음을 가정하고 사용하는 옵셔널. unowned 값이 nil이라 하면 크래쉬가 발생할 수 있음.
        apiWorker.fetchCandy { [unowned self] (candyEntity) in
            self.candyEntity = candyEntity
            self.presenter?.interactor(self, didFetch: candyEntity)
        }
    }
    
    func update(candyQuantity quantity: Int) {
        guard let candyEntity = self.candyEntity else { return }
        
        let totalPrice = candyEntity.price * Float(quantity)
        let tax = (totalPrice/100) * CandyInteractor.vat
        let totalInclTax = totalPrice + tax
        presenter?.interactor(self,
                              didUpdateTotalPrice: totalPrice,
                              totalInclTax: totalInclTax,
                              vat: CandyInteractor.vat,
                              quantity: quantity)
    }
}
