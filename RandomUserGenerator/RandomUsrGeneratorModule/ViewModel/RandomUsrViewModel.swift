//
//  RandomUsrViewModel.swift
//  RandomUserGenerator
//
//  Created by Minerva Nolasco Espino on 17/08/22.
//

import Foundation

public class RandomUsrViewModel : ServiceManagerDelegate {
    
    private lazy var serviceManager = ServiceManager()
    var randomUsrModel : Bindable<RandomUsrGeneratorModel?> = Bindable(nil)
    var arrResult : [RandomUsrGeneratorModel] = []
    let usrDefaultsKey = "locationUsrKey"
    
    func requestRandomUsrGenerate(){
        serviceManager.delegate = self
        serviceManager.sendRequest(urlString: "https://randomuser.me/api/")
    }
    
    func serviceResponse(_ responseData: Data?, _ error: Error?) {
        if let modelResponse = self.parseJSONUsrGenerator(UsrGeneratorData : responseData ?? Data()) {
            arrResult.append(modelResponse)
            setUsrDefaults(arr : arrResult)
            randomUsrModel.value = modelResponse
        }
    }
    
    func parseJSONUsrGenerator(UsrGeneratorData: Data) -> RandomUsrGeneratorModel? {
        let decoder = JSONDecoder()
        do{
            let decoderData = try decoder.decode(RandomUsrGeneratorModel.self, from: UsrGeneratorData)
            return decoderData
        } catch {
            print(error)
            return nil
        }
    }
    
    func setUsrDefaults(arr: [RandomUsrGeneratorModel] ) {
        do{
            let jsonEncoder = JSONEncoder()
            let arrEncoded = try jsonEncoder.encode(arr)
            UserDefaults.standard.setValue(arrEncoded, forKey: usrDefaultsKey)
            UserDefaults.standard.synchronize()
            print("Se guardo en user defaults")
        }
        catch{
            print("Error al guardar en userdefaults: \(error.localizedDescription)")
        }
    }
    
    func getInitialData(){
        arrResult = self.getUsrDefaults() ?? []
    }
    
    func removeUsrDefaults(){
        UserDefaults.standard.removeObject(forKey: usrDefaultsKey)
    }
    
    func getUsrDefaults() -> [RandomUsrGeneratorModel]? {
        guard let arrData = UserDefaults.standard.object(forKey: usrDefaultsKey) as? Data else{ return nil }
        do {
            let jsonDecoder = JSONDecoder()
            let arrModels = try jsonDecoder.decode([RandomUsrGeneratorModel].self, from: arrData)
            return arrModels
        } catch let error {
            print("Ocurrio un error al obtener data de userdefaults: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getnumberOfRows() -> Int {
        if let array = getUsrDefaults() {
            return array.count
        }
        return 0
    }
    
    func getCellForRow(index :Int) -> RandomUsrGeneratorModel? {
        guard let dataUsr = getUsrDefaults() else {
            return nil
        }
        return dataUsr[index]
    }
}
