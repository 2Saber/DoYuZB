//
//  RoomModel.swift
//  DYZB
//
//  Created by saber on 2020/10/31.
//

import Foundation
import UIKit
import KakaJSON

class Group: BaseModel {
    var icon_name: String?
    var icon_url: String?
    var small_icon_url: String = ""
    var tag_name: String = ""
    var tag_id: Int = 0
    var push_vertical_screen: CGFloat = 0
    var push_nearby:Int = 0
//    init(tag_name: String) {
//        self.tag_name = tag_name
//    }
//    
//    required init() {
//        fatalError("init() has not been implemented")
//    }
}

struct RoomModel: Convertible {
    var room_id: Int = 0
    var show_time: Int? = nil
    var recomType:Int = 0
    var hn:Int = 0
    var subject: String? = nil
    var vertical_src: String = ""
    var push_ios:Int = 0
    var cate_id:Int = 0
    var avatar_small = ""
    var specific_status: Int? = nil
    var room_src: String = ""
    var room_name = ""
    var game_name = ""
    var child_id: String? = nil
    var isVertical:Int = 0
    var vod_quality: String? = nil
    var ranktype: Int = 0
    var rpos: Int = 0
    var nickname: String = ""
    var online:Int = 0
    var show_status:Int = 0
    var specific_catalog: String? = nil
    var avatar_mid:String = ""
    var jumpUrl:String? = nil
    var push_nearby: Int = 0
    var nrt: Int = 0
    var rmf1: Int = 0
    var rmf2: Int = 0
    var rmf3: Int = 0
    var rmf4: Int = 0
}


