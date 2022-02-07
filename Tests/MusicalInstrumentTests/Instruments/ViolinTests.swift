import XCTest
import MusicSymbol

import MusicalInstrument

class ViolinTests: XCTestCase {

    /// test basic violin
    func testViolinBasic() {
        let violin = Violin.default
        
        violin.play(at: .C4, with: .velocity(60))
        sleep(3)

        violin.stop(at: .C4)
        sleep(2)
    }
    
    /// test play violin and stop
    func testStopAll() {
        let violin = Violin.default
        
        violin.play(at: Pitch("C4"), with: .velocity(60))
        violin.play(at: Pitch("E4"), with: .velocity(60))

        sleep(1)
        violin.stopAll()
        sleep(2)
    }

    /// test violin with pressure changes
    func testViolinWithPressureChange() {
        let violin = Violin.default
        
        violin.play(at: .C4, with: .default)
        sleep(1)
        violin.adjust(with: .pressure(100))
        sleep(1)
        violin.adjust(with: .pressure(10))
        sleep(1)
        
        violin.stopAll()
    }
    
    /// test violin with pressure changes
    func testViolinWithVolumeChange() {
        let violin = Violin.default
        
        violin.play(at: .C4, with: .default)
        
        for idx in 0..<10 {
            let volume = 100 - idx * 5
            violin.adjust(with: .volume(UInt8(volume)))
            print("volume", volume)
            Thread.sleep(forTimeInterval: 0.2)
        }
        
        for idx in 0..<15 {
            let volume = 50 + idx * 5
            violin.adjust(with: .volume(UInt8(volume)))
            print("volume", volume)
            Thread.sleep(forTimeInterval: 0.2)
        }
        
        violin.stopAll()
    }
}
