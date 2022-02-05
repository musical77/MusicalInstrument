//  AudioRecorderTests.swift
//
//  Copyright © 2022 live77. All rights reserved.

import XCTest
import MusicalInstrument

class AudioRecorderTests: XCTestCase {

    /// test audio recorder
    func testEngineRecording() {
        // init engine and recorder
        let engine = AudioEngine.default
        let recorder = AudioRecorder(audioEngine: engine)
        let pianoSampler = engine.sampler(.piano)!

        // first recording
        let url1 = makeURLInDir(fileNamed: "testEngineRecording1.caf")!
        XCTAssertTrue(recorder.startRecording(saveTo: url1))
        pianoSampler.startNote(60, withVelocity: 100, onChannel: 0)
        sleep(1)
        XCTAssertNotNil(recorder.stopRecording())
        
        // second recording
        let url2 = makeURLInDir(fileNamed: "testEngineRecording2.caf")!
        XCTAssertTrue(recorder.startRecording(saveTo: url2))
        sleep(1)
        pianoSampler.stopNote(60, onChannel: 0)
        XCTAssertNotNil(recorder.stopRecording())
    }
    

    func testEngineRecordingFileSize() {
        // init engine and recorder
        let engine = AudioEngine.default
        let recorder = AudioRecorder(audioEngine: engine)
        let pianoSampler = engine.sampler(.piano)!

        //
        let url = makeURLInDir(fileNamed: "testEngineRecording_size.caf")!
        XCTAssertTrue(recorder.startRecording(saveTo: url))
        pianoSampler.startNote(60, withVelocity: 100, onChannel: 0)
        sleep(1)
        pianoSampler.stopNote(60, onChannel: 0)

        XCTAssertNotNil(recorder.stopRecording())
        let size = getFileSize(url: url)
        print("file size = ", size / 1024, "KB")
        
        XCTAssertGreaterThan(size, 1000)
    }
    
    func makeURLInDir(fileNamed fileName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }
    
    func getFileSize(url: URL) -> Int {
        if let attr = try? FileManager.default.attributesOfItem(atPath: url.path) {
            return attr[FileAttributeKey.size] as! Int
        }
        return -1
    }
}


