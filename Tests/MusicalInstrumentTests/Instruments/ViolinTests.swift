import XCTest
import MusicSymbol

import MusicalInstrument

class ViolinTests: XCTestCase {

    /// test basic violin
    func testViolinBasic() {
        let violin = Violin.default
        
        let pitch = Pitch("C4")
        violin.play(at: pitch, with: .intensity(60))
        sleep(3)

        violin.stop(at: pitch)
        sleep(2)
    }
    
    /// test play violin and stop
    func testStopAll() {
        let violin = Violin.default
        
        violin.play(at: Pitch("C4"), with: .intensity(60))
        violin.play(at: Pitch("E4"), with: .intensity(60))

        sleep(1)
        violin.stopAll()
        sleep(2)
    }

}
