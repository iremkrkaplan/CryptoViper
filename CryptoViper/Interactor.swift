//
//  Interactor.swift
//  CryptoViper
//
//  Created by irem karakaplan on 27.07.2025.
//

import Foundation

//talks to -> presenter
//class, protocol
//apiden çekme işlemleri

protocol AnyInteractor {
    //kiminle konuşuyor? presenterla
    var presenter : AnyPresenter? {get set}
    
    func downloadCryptos()
    
}
class CryptoInteractor : AnyInteractor {
    
    var presenter: AnyPresenter?
    func downloadCryptos() {
        guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/IA32-CryptoComposeData/main/cryptolist.json") else {
            return
        }
    //buradaki [weak self]in amacı görünüm deiştiği zaman hafızada kalmayıp datanın da gitmesini sağlar
        
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                // Hatanın UI thread'inde işlenmesi için DispatchQueue.main.async kullanın
                DispatchQueue.main.async {
                    if let error = error {
                        self?.presenter?.interactorDidDownloadCrypto(result: .failure(error))
                        return
                    }
                    
                    guard let data = data else {
                        self?.presenter?.interactorDidDownloadCrypto(result: .failure(NetworkError.NetworkFailed)) // Veri yok hatası
                        return
                    }
                    
                    do {
                        let cryptos = try JSONDecoder().decode([Crypto].self, from: data)
                        self?.presenter?.interactorDidDownloadCrypto(result: .success(cryptos))
                    } catch {
                        self?.presenter?.interactorDidDownloadCrypto(result: .failure(error)) // JSON çözme hatası
                    }
                }
            }
        task.resume()
        
    }
    
}
