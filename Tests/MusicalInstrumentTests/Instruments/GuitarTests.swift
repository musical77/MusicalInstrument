//
//  GuitarTests.swift
//  
//
//  Created by liyihann on 2/22/23.
//  
//

import XCTest
import MusicSymbol
import MusicalInstrument

final class GuitarTests: XCTestCase {

    // test default guitar
    func testGuitarDefault() {
        let guitar = Guitar.default
        guitar.play(at: "C4", with: .velocity(60))
        Thread.sleep(forTimeInterval: 1.0)
        guitar.stopAll()
    }
    
    // test guitar chord
    func testGuitarChord() {
        let guitar = Guitar.default
        guitar.play(at: "C4", with: .velocity(60))
        guitar.play(at: "E4", with: .velocity(60))
        guitar.play(at: "G4", with: .velocity(60))
        Thread.sleep(forTimeInterval: 1.0)
        guitar.stopAll()
    }
    
    // test play guitar and stop
    func testStopAll() {
        let guitar = Guitar.default
        
        guitar.play(at: Pitch("C4"), with: .velocity(60))
        guitar.play(at: Pitch("E4"), with: .velocity(60))

        sleep(1)
        guitar.stopAll()
        sleep(2)
    }
    
}
