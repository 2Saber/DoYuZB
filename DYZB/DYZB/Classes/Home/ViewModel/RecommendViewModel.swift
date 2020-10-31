//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by saber on 2020/10/31.
//

import Foundation
import Alamofire
import KakaJSON

class RecommendViewModel {
    lazy var totalModel:[RoomModel] = [RoomModel]()
    fileprivate lazy var bigDataGroup:[RoomModel] = [RoomModel]()
    fileprivate lazy var prettyGroup:[RoomModel] = [RoomModel]()
    
}
extension RecommendViewModel {
    func requestData(model: Any, _ finishCallBack: @escaping () -> ())  {
//        let paraments = ["limit": 4, "offset": 0, "time": Date.getCurrent()] as [String: Any]
//        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: nil) { (result) in
//            print(result)
//        }
        let parameters = ["limit" : "30", "offset" : "0", "time" : Date.getCurrent()]
        
        let dGroup = DispatchGroup()
        
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrent()]) { (result) in
            guard let resultDict =  result as? [String: Any] else{ return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
            for dict in dataArray{
                self.bigDataGroup.append(dict.kj.model(type: RoomModel.self) as! RoomModel)
                
            }
//            print("bitData.coun = \(self.bigDataGroup.count)")
            dGroup.leave()
        }
        
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let resultDict = result as? [String: Any] else{ return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else{ return }
            for dict in dataArray {
                self.prettyGroup.append(dict.kj.model(type: RoomModel.self) as! RoomModel)
                
            }
//            print("prettyGroup.coun = \(self.prettyGroup.count)")
            dGroup.leave()
        }
        
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
            for dict in dataArray {
                self.totalModel.append(dict.kj.model(type: RoomModel.self) as! RoomModel)
                
            }
//            print("totoalGroup.coun = \(self.totalModel.count)")
            dGroup.leave()
        }
        dGroup.notify(queue: DispatchQueue.main) {
            self.totalModel.insert(contentsOf: self.prettyGroup, at: 0)
            self.totalModel.insert(contentsOf: self.bigDataGroup, at: 0)
            finishCallBack()
//            print(self.totalModel.count)
        }
        
//        finishCallBack(self.totalModel)
        
    }
    
}
