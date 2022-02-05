//
//  MusicalInstrument.swift
//

import Foundation
import MusicSymbol

/// interface for a musical instrument
public protocol MusicalInstrument {
    
    /// name of this instrument
    func name() -> String
    
    /// type of this instrument
    func type() -> InstrumentType
    
    /// play a note at given pitch with given guidance
    func play(at pitch: Pitch, with guidance: NotePlayGuidance)
    
    /// adjust the note while being played at given pitch
    func adjust(at pitch: Pitch, with guidance: NotePlayGuidance)
    
    /// stop playing a note at given pitch
    func stop(at pitch: Pitch)
    
    /// stop all the notes playing
    func stopAll()
    
}



