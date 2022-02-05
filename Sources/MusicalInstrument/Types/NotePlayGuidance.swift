//
//  NotePlayGuidance.swift
//

import Foundation

/// guidance for playing note
public struct NotePlayGuidance {
    public init(playIntenisty: UInt8) {
        self.playIntenisty = playIntenisty
    }
    
    /// play intensity (force)
    public var playIntenisty: UInt8
    
    /// default
    public static var `default` : NotePlayGuidance {
        return NotePlayGuidance(playIntenisty: 60)
    }
    
    /// sugar
    public static func intensity(_ intensity: UInt8) -> NotePlayGuidance {
        return NotePlayGuidance(playIntenisty: UInt8(intensity))
    }
}
