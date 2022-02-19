import XCTest
import MusicSymbol

import MusicalInstrument

class PianoAndViolinTests: XCTestCase {

    /// test piano and  violin together, also with audio recorder
    func testPianoAndViolinWithRecorder() {
        /// prepare piano and violin and audio recorder
        let piano = Piano.default
        let violin = Violin.default
        let recorder = AudioRecorder(audioEngine: .default)
        
        /// start recording
        _ = recorder.startRecording(saveTo: makeURLInDir(fileNamed: "pianoAndViolin.caf")!)
        
        /// let's play some music
        _ = violin.play(at: "E4", with: .velocity(100))
        _ = piano.play(at: "C4", with: .velocity(50))
            .play(at: "E4", with: .velocity(50))
            .play(at: "G4", with: .velocity(50))
        Thread.sleep(forTimeInterval: 1.0)
        violin.stop(at: "E4")
        piano.stopAll()
        
        violin.play(at: "D4", with: .velocity(50))
        piano.play(at: "B3", with: .velocity(50))
        piano.play(at: "D4", with: .velocity(50))
        piano.play(at: "G4", with: .velocity(50))
        Thread.sleep(forTimeInterval: 1.0)
        violin.stop(at: "D4")
        piano.stopAll()
    
        /// stop recording and get audio file
        let url = recorder.stopRecording()!
        print(url)
    }
   
    func makeURLInDir(fileNamed fileName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }
}

