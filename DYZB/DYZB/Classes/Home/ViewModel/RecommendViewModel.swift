//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by saber on 2020/10/31.
//

import Foundation
import Alamofire
import KakaJSON

class RecommendViewModel: BaseViewModel {
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup:Group = Group()
    fileprivate lazy var prettyGroup:Group = Group()
    
}
extension RecommendViewModel {
    func requestData(model: Any, _ finishCallBack: @escaping () -> ())  {

        let parameters = ["limit" : "6", "offset" : "4", "time" : Date.getCurrent()]
        let dGroup = DispatchGroup()
        
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters) { (result) in
            guard let resultDict =  result as? [String: Any] else{ return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
            self.bigDataGroup.room_list = [RoomModel]()
            for dict in dataArray{
//                let model = dict.kj.model(type: RoomModel.self) as! RoomModel
//                self.bigDataGroup.room_list?.append(model)
//                print(model)
                self.bigDataGroup.room_list?.append(dict.kj.model(type: RoomModel.self) as! RoomModel)
            }
            self.bigDataGroup.tag_name = "热点"
            self.bigDataGroup.icon_name = "home_header_hot"
            dGroup.leave()
        }
        
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            guard let resultDict = result as? [String: Any] else{ return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else{ return }
            self.prettyGroup.room_list = [RoomModel]()
            for dict in dataArray{
//                let model =
//                self.prettyGroup.room_list?.append(model)
//                print(model)
                self.prettyGroup.room_list?.append(dict.kj.model(type: RoomModel.self) as! RoomModel)
            }
//            print("prettyGroup.coun = \(self.prettyGroup.room_list.count)")
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            dGroup.leave()
        }
        
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: ["time" : Date.getCurrent()]) { (result) in
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String: Any]] else { return }
            for dict in dataArray {
                self.totalModel.append(dict.kj.model(type: Group.self) as! Group)
//                print("dataArry.count = \(self.totalModel)")
            }
//            print("total.count = \(self.totalModel.count)")
            dGroup.leave()
        }
        dGroup.notify(queue: DispatchQueue.main) {
            self.totalModel.insert(self.prettyGroup, at: 0)
            self.totalModel.insert(self.bigDataGroup, at: 0)
            finishCallBack()
        }
        
    }
    
    func requeCycyleDaga(modle: Any, _ finishCallBack: @escaping () -> ())  {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6") { (retult) in
            guard let dataDict = retult as? [String : Any] else { return }
            guard let dataArray = dataDict["data"] as? [[String : Any]] else { return }
            for dict in dataArray {
                self.cycleModels.append(dict.kj.model(type: CycleModel.self) as! CycleModel)
            }
            finishCallBack()
        }
    }
    
}
