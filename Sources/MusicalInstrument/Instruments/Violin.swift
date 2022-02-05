//  Violin.swift
//
//  Copyright © 2022 live77. All rights reserved.

import Foundation
import MusicSymbol
import AVFAudio

/// violin
public class Violin : MusicalInstrument {
    
    public func play(at pitch: Pitch, with guidance: NotePlayGuidance) {
        controller.play(at: pitch, with: guidance.playIntenisty)
    }
    
    public func adjust(at pitch: Pitch, with guidance: NotePlayGuidance) {
        // not supported yet
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

    public func type() -> InstrumentType {
        return .violin
    }

    public init(sampler: AVAudioUnitSampler) {
        self.controller = SamplerController(sampler: sampler)
    }
    
    /// default, easy to use Violine
    public static var `default` : Violin = {
        let engine = AudioEngine.default
        let sampler = engine.sampler(.violin)!
        return Violin(sampler: sampler)
    }()

    /// private
    private let controller: SamplerController
}
