//
//  ServiceManager.swift
//  RandomUserGenerator
//
//  Created by Minerva Nolasco Espino on 17/08/22.
//

import Foundation

protocol ServiceManagerDelegate {
    func serviceResponse(_ responseData: Data?, _ error: Error?)
}

struct ServiceManager {
    
    var delegate : ServiceManagerDelegate?
    
    func sendRequest(urlString : String) {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    print("🚨 Ocurrio un error al consultar el servicio \(String(describing: error!))")
                    delegate?.serviceResponse(nil, error)
                    return
                }
                if let safeData = data {
                    delegate?.serviceResponse(safeData, nil)
                }else{
                    delegate?.serviceResponse(nil, nil)
                }
            }
            task.resume()
        }
    }
    
    func sendRequestWithClosure(urlString : String, handler : @escaping (_ data: Data?, _ error: Error?) -> ()){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    print("🚨 Ocurrio un error al consultar el servicio \(String(describing: error!))")
                    handler(nil, error)
                    return
                }
                if let safeData = data {
                    handler(safeData, nil)
                }else{
                    handler(nil, nil)
                }
            }
            task.resume()
        }
    }
}
