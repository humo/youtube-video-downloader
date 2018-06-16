//
//  PlayerControlView.swift
//  youtube video downloader
//
//  Created by Vlad on 16.06.2018.
//  Copyright © 2018 Vlad. All rights reserved.
//

import UIKit

protocol PlayerControlViewDelegate: class {
    func nextSong() -> ITunesSong?
    func previous() -> ITunesSong?
}

class PlayerControlView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton! {
        didSet {
            playPauseButton.addTarget(self, action: #selector(self.playPauseButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.addTarget(self, action: #selector(self.nextButtonAction), for: .touchUpInside)
        }
    }
    @IBOutlet weak var previousButton: UIButton! {
        didSet {
            previousButton.addTarget(self, action: #selector(self.previousButtonAction), for: .touchUpInside)
        }
    }
    
    private var isPlaying: Bool = false
    private var player = ITunesPlayer()
    weak var delegate: PlayerControlViewDelegate?

    func configureFor(song: ITunesSong) {
        player.delegate = self
        player.setSongBy(urlStr: song.url)
        titleLabel.text = song.songName + " - " + song.authorName
    }
}

@objc extension PlayerControlView {
    private func playPauseButtonAction() {
        if isPlaying {
            player.stop()
        } else {
            nextButtonAction()
        }
    }
    
    private func nextButtonAction() {
        if let song = delegate?.nextSong() {
            configureFor(song: song)
        }
    }
    
    private func previousButtonAction() {
        if let song = delegate?.previous() {
            configureFor(song: song)
        }
    }
}

extension PlayerControlView: ITunesPlayerDelegate {
    func startLoad() {
        
    }
    func endLoad() {
        
    }
    func error() {
        
    }
}

extension PlayerControlView {
    class func loadFromXib() -> PlayerControlView {
        let nib = UINib(nibName: "PlayerControlView", bundle: nil)
        let views = nib.instantiate(withOwner: nil, options: nil)
        return views.first as! PlayerControlView
    }
}
