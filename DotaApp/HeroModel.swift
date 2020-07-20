//
//  DataModel.swift
//  DotaApp
//
//  Created by Emin Bari on 18.07.2020.
//  Copyright © 2020 Emin Bari. All rights reserved.
//

import Foundation

struct  HeroModel:Decodable {
    let localized_name: String
    let attack_type: String
    let img: String
    let icon: String
    let base_health: Int
}
