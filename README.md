# MusicalInstrument

[![Swift](https://github.com/musical77/MusicalInstrument/actions/workflows/swift.yml/badge.svg)](https://github.com/musical77/MusicalInstrument/actions/workflows/swift.yml)


Play musical instrument in just few lines of swift code. 


Requirements
----
* Swift 5.0+
* iOS 14.0+
* macOS 13.0+


Install
----

### Swift Package Manager

``` swift
let package = Package(
  dependencies: [
    .package(url: "https://github.com/musical77/MusicalInstrument.git")
  ],
)
```


Usage
----

`MusicalInstrument` supports `Piano` and `Violin` right now. 

### Get a Piano and play with it!

You can hear the center C of the piano playing from the speakers.

``` swift
// create a piano, and play middle C for a second.
let piano = Piano.default
piano.play(at: "C4", with: .velocity(60))
Thread.sleep(forTimeInterval: 1.0)
piano.stop(at: "C4")
```

### Get a Violin and a Piano and play with it!

In this example, you can hear the sound, also get a recorded audio file.
``` swift 
// prepare piano and violin and audio recorder
let piano = Piano.default
let violin = Violin.default
let recorder = AudioRecorder(audioEngine: .default)

// start recording, save audio file (*.caf) to your faviorate destination.
_ = recorder.startRecording(saveTo: URL(...))

// let's play some music
violin.play(at: "E4", with: .velocity(100))
piano.play(at: "C4", with: .velocity(50))
piano.play(at: "E4", with: .velocity(50))
piano.play(at: "G4", with: .velocity(50))
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

// stop recording and get audio file
let url = recorder.stopRecording()
print(url)
```

#### Recorded Audio Example 

https://github.com/musical77/MusicalInstrument/blob/main/Examples/audio/pianoAndViolin.caf?raw=true

### Play Piano with Pedal Control

``` swift 
let piano = Piano.default

// padal on , then press the key
piano.pedalOn()
piano.play(at: .C4, with: .velocity(60))
Thread.sleep(forTimeInterval: 0.10)
piano.stop(at: .C4)
// duration the following 2 seconds, sound still exists
Thread.sleep(forTimeInterval: 2.0)
        
// release the padel, sounds off
print("padel off")
piano.pedalOff()
Thread.sleep(forTimeInterval: 2.0)

```



Reference
---

https://www.midi.org/midi-articles/about-midi-part-3-midi-messages

MIDI FILE Format

http://www.music.mcgill.ca/~ich/classes/mumt306/StandardMIDIfileformat.html
