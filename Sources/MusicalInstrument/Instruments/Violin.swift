//  Violin.swift
//
//  Copyright © 2022 live77. All rights reserved.

import Foundation
import MusicSymbol
import AVFAudio

/// violin
public class Violin: MusicalInstrument {
    
    public func play(at pitch: Pitch, with option: NotePlayingOption) {
        controller.play(at: pitch, with: option.noteOnVelocity)
    }
    
    public func adjust(with option: InstrumentControlOption) {
        switch option {
        case .pressure(let pressure):
            controller.sendPressure(pressure: pressure)
        case .volume(let volume):
            controller.sendController(SamplerController.VOLUME_CONTROL, withValue: volume)
        }
    }
    
    public func stop(at pitch: Pitch) {
        controller.stop(at: pitch)
    }
    
    public func stopAll() {
        controller.stopAll()
    }
    
    public func name() -> String {
        return "Violin"
    }

    public func type() -> InstrumentFamily {
        return .strings
    }

    public init(sampler: AVAudioUnitSampler) {
        self.controller = SamplerController(sampler: sampler)
    }
    
    /// default, easy to use Violine
    public static var `default` : Violin = {
        let engine = AudioEngine.default
        let sampler = engine.sampler(.strings)!
        return Violin(sampler: sampler)
    }()

    /// private
    private let controller: SamplerController
}
