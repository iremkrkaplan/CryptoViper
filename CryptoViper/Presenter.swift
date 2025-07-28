//
//  Presenter.swift
//  CryptoViper
//
//  Created by irem karakaplan on 27.07.2025.
//

import Foundation

//talks to -> interactor, view, router
//class, protocol

enum NetworkError : Error{
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter{
    //değişken get mi olacak get set mi olacak belirtmeliyiz yani sadece okunacak mı yoksa {get} yoksa değeri de değiştirecek mi {get set}
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    //result içerisinde success ve errorn: Resultı kullanarak success duruöunda crypto dizisi error durumunda error
    func interactorDidDownloadCrypto(result: Result<[Crypto],Error>)
}
class CryptoPresenter : AnyPresenter{
    var router: (any AnyRouter)?
    
    var interactor: (any AnyInteractor)?{
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    
    var view: (any AnyView)?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], any Error>) {
        switch result{
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "Error: Try again")
        }
    }
    
    
}
