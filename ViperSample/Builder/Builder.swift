//
//  Builder.swift
//  ViperSample
//
//  Created by Seungchul Lee on 2023/03/28.
//

import Foundation

class CandyBuilder {
    class func buildModule(arroundView view: CandyViewProtocol){
        let presenter = CandyPresenter()
        let interactor = CandyInteractor(withApiWorker: CandyAPIWorker())
        let router = CandyRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireframe = router
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
}
