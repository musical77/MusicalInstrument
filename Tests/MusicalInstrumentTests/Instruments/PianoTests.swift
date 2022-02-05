import XCTest
import MusicSymbol
import MusicalInstrument


class PianoTests: XCTestCase {


    /// play piano for a fixed pitch with different touch duration
    func testPianoDurationVariance() {
        let engine = AudioEngine.default
        let pianoSampler = engine.sampler(.piano)!
        let piano = Piano(sampler: pianoSampler)

        let pitch = Pitch("C4")
        for idx in 1...20 {
            let duration = Double(idx) * 0.01 // duration start form 10ms
            piano.play(at: pitch, with: NotePlayGuidance(playIntenisty: 60))
            Thread.sleep(forTimeInterval: duration)
            piano.stop(at: pitch)
            
            print("test piano play duration: \(idx), duration: \(duration)")
            Thread.sleep(forTimeInterval: 0.1)
        }
        
        piano.stopAll()
    }

    
    /// play piano from lowest pitch to highest
    func testPianoPitchVariance() {
        let piano = Piano.default
        
        for midiNote: Int in 0...127 {
            let pitch = Pitch(midiNote: midiNote)
            piano.play(at: pitch, with: .intensity(60))
            Thread.sleep(forTimeInterval: 0.05)
            piano.stop(at: pitch)

            print("test piano play pitch: \(pitch.description), duration: \(0.05)")
            Thread.sleep(forTimeInterval: 0.05)
        }

        piano.stopAll()
    }
    

    /// play piano with different press velocity
    func testPianoVelocityVariance() {
        let piano = Piano.default
        
        for velocity: UInt8 in 0...127 {
            let pitch = Pitch(60)
            piano.play(at: pitch, with: .intensity(velocity))
            Thread.sleep(forTimeInterval: 0.10)
            piano.stop(at: pitch)

            print("test piano play pitch: \(pitch), velocity: \(velocity)")
            Thread.sleep(forTimeInterval: 0.05)
        }

        piano.stopAll()
    }
    
    /// test default piano
    func testPianoDefault() {
        let piano = Piano.default
        piano.play(at: "C4", with: .intensity(60))
        Thread.sleep(forTimeInterval: 1.0)
        piano.stop(at: "C4")
    }
}

