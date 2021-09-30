import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  _MusicPlayerState createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  //AudioPlayer from the "audioplayers" package
  AudioPlayer _audioPlayer = new AudioPlayer();

  /*
  Used to toggle between playback speeds.
  Primarily used to allow a switch statement in the togglePlaybackSpeed
  method instead of if statements as switch doesnt support double
  */
  int _playbackSpeedSetting = 0;

  //Actual playback speed
  double _playbackSpeed = 1.0;

  //Keeps track of the song currently playing. -1 means no song selected
  int _currentlyPlayingSong = -1;

  //State of the play/pause button
  bool _showPause = false;

  //List of songs from table 1
  List<String> _songs = [
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
    "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3",
  ];

  //Pauses the song playing
  pauseMusic() async {
    setState(() {
      _showPause = false;
    });
    await _audioPlayer.pause();
  }

  //Plays the song at index position in the songs list with selected speed setting
  playSong(int index) async {
    setState(() {
      _currentlyPlayingSong = index;
      _showPause = true;
    });
    await _audioPlayer.play(_songs[index]);
    await _audioPlayer.setPlaybackRate(_playbackSpeed);
  }

  //Resumes the paused or stopped song with selected speed setting
  resumeMusic() async {
    try {
      await _audioPlayer.resume();
      await _audioPlayer.setPlaybackRate(_playbackSpeed);
      if (_currentlyPlayingSong != -1) {
        setState(() {
          _showPause = true;
        });
      }
    } catch (e) {
      //Some error message could be displayed to the user
    }
  }

  //Stops song - the song can't be resumed and will have to play from the start
  stopMusic() async {
    await _audioPlayer.stop();
    setState(() {
      _showPause = false;
    });
  }

  //Skips to previous song
  previousSong(int index) async {
    if (0 > index - 1) {
      await playSong(_songs.length - 1);
    } else {
      await playSong(index - 1);
    }
  }

  //Skips to next song
  nextSong(int index) async {
    if (_songs.length - 1 < index + 1) {
      await playSong(0);
    } else {
      await playSong(index + 1);
    }
  }

  //Returns the name of the song playing or "" if no song is playing
  String getCurrentlyPlayingSong() {
    if (_currentlyPlayingSong == -1) {
      return "";
    }
    return 'Song ' + (_currentlyPlayingSong + 1).toString();
  }

  //Toggles between playback speeds 1.0x, 1.5x and 0.8x
  togglePlaybackSpeed() async {
    switch (_playbackSpeedSetting) {
      case 0:
        _playbackSpeedSetting = 1;
        setState(() {
          _playbackSpeed = 1.5;
        });
        break;
      case 1:
        _playbackSpeedSetting = 2;
        setState(() {
          _playbackSpeed = 0.8;
        });
        break;
      default:
        _playbackSpeedSetting = 0;
        setState(() {
          _playbackSpeed = 1.0;
        });
    }
    await resumeMusic();
    await _audioPlayer.setPlaybackRate(_playbackSpeed);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _songs.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                child: Card(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                  ),
                  color: Colors.lightGreen[100],
                  child: ListTile(
                    title: Text(
                      'Song ${index + 1}',
                      style: TextStyle(fontSize: 20),
                    ),
                    leading: Transform.scale(
                      scale: 1.5,
                      child: Icon(Icons.music_note),
                    ),
                  ),
                ),
                onTap: () => playSong(index),
              );
            },
          ),
        ),
        //UI for player controls
        Column(
          children: [
            Center(
              child: Text(
                getCurrentlyPlayingSong(),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => previousSong(_currentlyPlayingSong),
                  child: Icon(
                    Icons.skip_previous,
                  ),
                ),
                ElevatedButton(
                  onPressed: stopMusic,
                  child: Icon(
                    Icons.stop,
                  ),
                ),
                ElevatedButton(
                  onPressed: _showPause ? pauseMusic : resumeMusic,
                  child: Icon(
                    _showPause ? Icons.pause : Icons.play_arrow,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => togglePlaybackSpeed(),
                  child: Text("$_playbackSpeed x"),
                ),
                ElevatedButton(
                  onPressed: () => nextSong(_currentlyPlayingSong),
                  child: Icon(
                    Icons.fast_forward,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
