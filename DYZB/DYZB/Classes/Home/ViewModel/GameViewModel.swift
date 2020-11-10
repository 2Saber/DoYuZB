//
//  GameViewModel.swift
//  DYZB
//
//  Created by saber on 2020/11/3.
//

import Foundation

class GameViewModel : BaseViewModel {
//    fileprivate var games : Group = Group()
}
extension GameViewModel{
    func loadAllGames(finishCallBack: @escaping () -> ()) {

        func loadGameData(finishCallBack : @escaping () ->())  {
            NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (response) in
                guard let resultDict = response as? [String: Any] else { return }
                guard let dataArry = resultDict["data"] as? [[String: Any]] else { return }
                let tmpGroup = Group()
                tmpGroup.room_list = dataArry.kj.modelArray(type: BaseModel.self)
                self.totalModel = [tmpGroup]                
            }
        }
    }
}
