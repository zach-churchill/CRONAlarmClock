//
//  CustomSymbols.swift
//  CRONAlarmClock
//
//  Created by Zachary Churchill on 10/2/20.
//

import UIKit

class CustomSymbols {

    static var deleteSymbol: UIImage? {
        let symbolConfig = UIImage.SymbolConfiguration(weight: .semibold)
        let symbol = UIImage(systemName: "trash", withConfiguration: symbolConfig)
        return symbol?.withTintColor(UIColor.accent, renderingMode: .alwaysOriginal)
    }
}
