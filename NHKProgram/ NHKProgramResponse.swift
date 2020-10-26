//
//   NHKProgramResponse.swift
//  NHKproject
//
//  Created by cmStudent on 2020/08/11.
//  Copyright © 2020 20CM0103. All rights reserved.
//

import Foundation
struct NHKProgramResponce: Codable {
    let list: NHKService
    
    struct NHKService: Codable {
        let g1: [NHKprogram]
        
        struct NHKprogram: Codable {
            let id: String    //番組ID    ◯
            let event_id:  String    //番組イベントID    ◯
            let start_time: String    //放送開始日時（YYYY-MM-DDTHH:mm:ssZ形式）    ◯
            let end_time: String    //放送終了日時（YYYY-MM-DDTHH:mm:ssZ形式）    ◯
            let area: Area    //Areaオブジェクト    ◯
            let service : Service    //Serviceオブジェクト    ◯
            let title : String    //番組名    ◯
            let subtitle: String    //番組内容    ◯
            let genres: [String]   //番組ジャンル    ◯
            
            struct Area: Codable {
                let id: String
                let name: String
                
            }
            struct Service: Codable {
                let id: String
                let name: String
                let logo_s: Logo
                let logo_m: Logo
                let logo_l: Logo
                
                struct Logo: Codable {
                    let url: String
                    let width: String
                    let height: String
                }
            }
        }
    }
    
}
