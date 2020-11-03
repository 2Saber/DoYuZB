//
//  GameViewModel.swift
//  DYZB
//
//  Created by saber on 2020/11/3.
//

import Foundation

class GameViewModel : BaseViewModel {
    fileprivate var games : Group = Group()
}
extension GameViewModel{
    func loadAllGames(finishCallBack: @escaping () -> ()) {

//        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
//
//        }
    }
}
