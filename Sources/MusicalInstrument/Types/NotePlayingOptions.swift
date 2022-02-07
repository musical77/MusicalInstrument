//
//  NotePlayGuidance.swift
//

import Foundation

/// options for playing note on a instrument
public struct NotePlayingOptions {
    public init(playIntenisty: UInt8) {
        self.playIntenisty = playIntenisty
    }
    
    /// play intensity (force)
    public var playIntenisty: UInt8
    
    /// default
    public static var `default` : NotePlayingOptions {
        return NotePlayingOptions(playIntenisty: 60)
    }
    
    /// sugar
    public static func intensity(_ intensity: UInt8) -> NotePlayingOptions {
        return NotePlayingOptions(playIntenisty: UInt8(intensity))
    }
}
