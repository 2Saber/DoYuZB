//
//  RoomModel.swift
//  DYZB
//
//  Created by saber on 2020/10/31.
//

import Foundation
import UIKit
import KakaJSON

struct RoomModel: Convertible {
    var room_id: Int = 0
    var show_time: Int? = nil
    var recomType:Int = 0
    var hn:Int = 0
    var vertical_src: String = ""
    var push_ios:Int = 0
    var cate_id:Int = 0
    var avatar_small = ""
    var specific_status: Int? = nil
    var room_src: String = ""
    var room_name = ""
    var game_name = ""
    var isVertical:Int = 0
    var ranktype: Int = 0
    var nickname: String = ""
    var online:Int = 0
    var show_status:Int = 0
    var avatar_mid:String = ""

}
