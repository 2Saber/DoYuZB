//
//  File.swift
//  DYZB
//
//  Created by saber on 2020/11/9.
//

import Foundation
import KakaJSON

class BaseModel:Convertible {
    var room_list: [Any]?
    required init() {}
    func kj_modelType(from jsonValue: Any?, _ property: Property) -> Convertible.Type? {
        if property.name == "room_list" {
            if let model = jsonValue as? RoomModel, model.room_id != 0 {
                return RoomModel.self
            }else if let model = jsonValue as? GameModel, let _ = model.pic_name{
                return GameModel.self
            }
            return nil
        }
        return nil
    }
}
