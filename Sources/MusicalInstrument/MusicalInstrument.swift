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
    func type() -> InstrumentFamily
    
    /// play a note at given pitch with given guidance
    func play(at pitch: Pitch, with option: NotePlayingOption)
    
    /// stop playing a note at given pitch
    func stop(at pitch: Pitch)
    
    /// adjust the instrument with given option
    func adjust(with option: InstrumentControlOption)
    
    /// stop all the notes playing
    func stopAll()
    
}



