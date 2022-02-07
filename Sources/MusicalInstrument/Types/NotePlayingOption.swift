//
//  NotePlayingOption.swift
//

import Foundation

/// options for playing note on a instrument
public struct NotePlayingOption {
    public init(noteOnVelocity: UInt8) {
        self.noteOnVelocity = noteOnVelocity
    }
    
    /// velocity(force) of playing this note on instrument, usually the faster the velocity, the louder the sounds made from
    /// the instrument.
    public var noteOnVelocity: UInt8
    
    /// default
    public static var `default` : NotePlayingOption {
        return NotePlayingOption(noteOnVelocity: 60)
    }
    
    /// sugar
    public static func velocity(_ velocity: UInt8) -> NotePlayingOption {
        return NotePlayingOption(noteOnVelocity: UInt8(velocity))
    }
}
