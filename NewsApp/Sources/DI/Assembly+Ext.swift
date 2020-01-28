//
//  Assembly+Ext.swift
//  NewsApp
//
//  Created by Дмитрий Куприянов on 25.01.2020.
//  Copyright © 2020 testapp. All rights reserved.
//

import Swinject

extension Assembler {
    
    static let shared: Assembler = {
        let container = Container()
        
        let assembler = Assembler([
            AppAssemble()
        ])
        
        return assembler
    }()
}
