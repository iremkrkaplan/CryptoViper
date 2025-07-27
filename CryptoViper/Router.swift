//
//  Router.swift
//  CryptoViper
//
//  Created by irem karakaplan on 27.07.2025.
//

import Foundation
import UIKit


//class, protocol
//entryPoint
//uygulama ilk açıldığında nereye gidecek gibi soruları cevaplar
//V,I,P ı kontrol etmek için var

//entrypoint gördüğümüz her yer AnyView & UIViewController dır. AnyView & UIViewControllerları optional yapabilmek için. typealias: Mevcut bir türe (veri tipine) yeni bir isim vermemizi sağlar.
typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter{
    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
}

class CryptoRouter : AnyRouter {
    var entry: EntryPoint?
    
    
    static func startExecution() -> any AnyRouter {
        let router = CryptoRouter()
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        //cryptoviewcontrollerın AnyView & UIViewController ikisi de olduğunu biliyoruz
        router.entry = view as? EntryPoint
        return router
    }
    
    
}
