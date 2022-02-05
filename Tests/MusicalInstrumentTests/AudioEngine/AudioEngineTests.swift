//  AudioEngineTests.swift
//
//  Copyright © 2022 live77. All rights reserved.

import XCTest
import MusicalInstrument

class AudioEngineTests: XCTestCase {

    /// tset audio engine inti and sampler
    func testEngineBasic() {
        let engine = AudioEngine.default
        XCTAssertNotNil(engine)
        
        let pianoSampler = engine.sampler(.piano)
        XCTAssertNotNil(pianoSampler)
        let violinSampler = engine.sampler(.violin)
        XCTAssertNotNil(violinSampler)

        pianoSampler!.startNote(60, withVelocity: 100, onChannel: 0)
        sleep(1)
        violinSampler!.startNote(64, withVelocity: 64, onChannel: 0)
        sleep(1)
        violinSampler!.startNote(67, withVelocity: 64, onChannel: 0)

        sleep(1)
        pianoSampler!.stopNote(60, onChannel: 0)
        sleep(1)

        violinSampler!.stopNote(64, onChannel: 0)
        violinSampler!.stopNote(67, onChannel: 0)
    }

}

