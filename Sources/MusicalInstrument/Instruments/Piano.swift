//  Piano.swift
//
//  Copyright © 2022 live77. All rights reserved.

import Foundation
import AVFoundation
import MusicSymbol

public class Piano: MusicalInstrument {
    
    @discardableResult public func play(at pitch: Pitch, with option: NotePlayingOption) -> MusicalInstrument {
        controller.play(at: pitch, with: option.noteOnVelocity)
        return self
    }
    
    public func adjust(with option: InstrumentControlOption) {
        // not supported yet
        assertionFailure("not supported yet in Piano")
    }
    
    @discardableResult public func stop(at pitch: Pitch) -> MusicalInstrument {
        controller.stop(at: pitch)
        return self
    }
    
    public func stopAll() {
        controller.stopAll()
    }
    
    public func name() -> String {
        return "Piano"
    }
    
    public func type() -> InstrumentFamily {
        return .piano
    }
    
    public init(sampler: AVAudioUnitSampler) {
        controller = SamplerController(sampler: sampler)
    }
    
    /// default, easy to use Piano
    public static var `default` : Piano = {
        let engine = AudioEngine.default
        let sampler = engine.sampler(.piano)!
        return Piano(sampler: sampler)
    }()
    
    // MARK: private
    private let controller : SamplerController
}

/// pedal operation
public extension Piano {
    
    /// pedal on
    func pedalOn() {
        controller.sendController(SamplerController.PEDAL_CONTROL, withValue: 127)
    }
    
    /// pedal off
    func pedalOff() {
        controller.sendController(SamplerController.PEDAL_CONTROL, withValue: 0)
    }
    
    /// * Damper pedal on/off (Sustain)    <63=off    >64=on
//    private static let PEDAL: UInt8 = 64
}

