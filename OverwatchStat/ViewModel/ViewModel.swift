//
//  ViewModel.swift
//  Valorant
//
//  Created by danyaq on 02.09.2021.
//

import Foundation
import Alamofire

class ViewModel: ObservableObject{
    @Published var model: MainModel?
    @Published var errorMsg = "Неверный Battle tag"
    init(){
        fetchData(battleTag: "cats-11481")
    }
    func fetchData(battleTag: String, com: ((_ Error: String) -> Void)? = nil){
        let url = "https://ow-api.com/v1/stats/pc/us/\(battleTag)/profile"
        AF.request(url, method: .get).validate().responseJSON{ response in
            switch response.result{
            case .success:
                do{
                    let decoder = try JSONDecoder().decode(MainModel.self, from: response.data!)
                    self.model = decoder
                    print(self.model ?? "nil data")
               
                } catch let error{
                    print(error.localizedDescription)
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                com!(error.localizedDescription)
            }
        }
    }
}

