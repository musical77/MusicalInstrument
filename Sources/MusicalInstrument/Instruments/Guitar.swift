//
//  File.swift
//  
//
//  Created by liyihann on 2/22/23.
//  
//

import Foundation
import MusicSymbol
import AVFAudio

// guitar
public class Guitar: MusicalInstrument {
    
    @discardableResult public func play(at pitch: Pitch, with option: NotePlayingOption) -> MusicalInstrument {
        controller.play(at: pitch, with: option.noteOnVelocity)
        return self
    }
    
    @discardableResult public func stop(at pitch: Pitch) -> MusicalInstrument {
        controller.stop(at: pitch)
        return self
    }
    
    public func adjust(with option: InstrumentControlOption) {
        // not supported yet
        assertionFailure("Not supported yet")
    }

    public func stopAll() {
        controller.stopAll()
    }
    
    public func name() -> String {
        return "Guitar"
    }

    public func type() -> InstrumentFamily {
        return .guitar
    }

    public init(sampler: AVAudioUnitSampler) {
        self.controller = SamplerController(sampler: sampler)
    }
    
    /// default, easy to use 
    public static var `default` : Guitar = {
        let engine = AudioEngine.default
        let sampler = engine.sampler(.guitar)!
        return Guitar(sampler: sampler)
    }()

    /// private
    private let controller: SamplerController
}

