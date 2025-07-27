//
//  Router.swift
//  CryptoViper
//
//  Created by irem karakaplan on 27.07.2025.
//

import Foundation


//class, protocol
//entryPoint
//uygulama ilk açıldığında nereye gidecek gibi soruları cevaplar
//VIP ı kontrol etmek için var

protocol AnyRouter{
    static func startExecution() -> AnyRouter
}

class CryptoRouter : AnyRouter {
    
    static func startExecution() -> any AnyRouter {
        let router = CryptoRouter()
        return router
    }
    
    
}
