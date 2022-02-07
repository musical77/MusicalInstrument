//  InstrumentControlOption.swift
//
//  Created by lively77 on 2022/2/7.

import Foundation

public enum InstrumentControlOption {
    
    /// pressure on this instrument
    case pressure(UInt8)
    
    /// output volume, Volume (7) defaults to 100 so you can bump it up a bit.
    case volume(UInt8)
}
