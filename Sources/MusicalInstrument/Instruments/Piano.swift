//  Piano.swift
//
//  Copyright © 2022 live77. All rights reserved.

import Foundation
import AVFoundation
import MusicSymbol

public class Piano : MusicalInstrument {
    public func play(at pitch: Pitch, with option: NotePlayingOption) {
        controller.play(at: pitch, with: option.noteOnVelocity)
    }
    
    public func adjust(with option: InstrumentControlOption) {
        // not supported yet
    }
    
    public func stop(at pitch: Pitch) {
        controller.stop(at: pitch)
    }
    
    public func stopAll() {
        controller.stopAll()
    }
    
    public func name() -> String {
        return "Piano"
    }
    
    public func type() -> InstrumentType {
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
    
    func adjustInstrument(_ pedalOn: Bool) {
        if pedalOn {
            controller.sendController(Piano.PEDAL, withValue: 127)
        }  else {
            controller.sendController(Piano.PEDAL, withValue: 0)
        }
    }
       
    
    /// pedal on
    func pedalOn() {
        adjustInstrument(true)
    }
    
    /// pedal off
    func pedalOff() {
        adjustInstrument(false)
    }
    
    private static let PEDAL: UInt8 = 64
}

