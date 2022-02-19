//
//  MusicalInstrument.swift
//

import Foundation
import MusicSymbol

/// interface for a musical instrument
/// The purpose of this interface is to simulate a real instrument, and all operations on the instrument are instantaneous feedback,
/// including functions such as playing notes, stopping playing, and adjusting the status of the instrument.
public protocol MusicalInstrument {
    
    /// name of this instrument
    func name() -> String
    
    /// type of this instrument
    func type() -> InstrumentFamily
    
    /// play a note at given pitch with given guidance
    @discardableResult func play(at pitch: Pitch, with option: NotePlayingOption) -> MusicalInstrument
    
    /// stop playing a note at given pitch
    @discardableResult func stop(at pitch: Pitch) -> MusicalInstrument
    
    /// adjust the instrument with given option
    func adjust(with option: InstrumentControlOption)
    
    /// stop all the notes playing
    func stopAll()
}

public extension MusicalInstrument {
    @discardableResult func play(at pitch: Pitch) -> MusicalInstrument {
        return play(at: pitch, with: .default)
    }
}


