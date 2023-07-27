
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter audio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController iconController;
  bool isAnimated = false;
  bool showPlay = true;
  bool shopPause = false;
  double _volume = 1.0;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  void _loadAudio(String audioPath) {
  if (audioPath.startsWith('http')) {
    // Web URL
    audioPlayer.open(Audio.network(audioPath), autoStart: false, showNotification: true);
  } else {
    // Local file
    audioPlayer.open(Audio(audioPath), autoStart: false, showNotification: true);
  }
}
  @override
   void initState() {
    super.initState();
    iconController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    // Load and play the web audio URL here
    String webAudioUrl = 'https://media.radioinstore.in/songs/Tamil/1987/rettai%20val%20kuruvi/raja%20raja%20cholan_kj%20jesudoss.mp3';
    _loadAudio(webAudioUrl);
    audioPlayer.play();
  }


  
/*
  // List of audio paths
  List<String> audioPaths = [
    'assets/036.mp3',
    'assets/018.mp3',
    'assets/020.mp3',
    'assets/021.mp3',
    'assets/022.mp3',
    'assets/023.mp3',
    'assets/024.mp3',
    'assets/025.mp3',
    'assets/026.mp3',
    'assets/029.mp3',
  ];

  int currentAudioIndex = 0;*/


 /*
//next audio
  void _playNextAudio() {
    if (currentAudioIndex < audioPaths.length - 1) {
      currentAudioIndex++;
      _loadAudio(audioPaths[currentAudioIndex]);
      audioPlayer.play();
      setState(() {
        isAnimated = true;
        iconController.forward();
      });
    }
  }
//previous audio
  void _playPreviousAudio() {
    if (currentAudioIndex > 0) {
      currentAudioIndex--;
      _loadAudio(audioPaths[currentAudioIndex]);
      audioPlayer.play();
      setState(() {
        isAnimated = true;
        iconController.forward();
      });
    }
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(" Audio player "),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              // previous button
           /*     IconButton(
                  icon: Icon(Icons.skip_previous),
              onPressed: () {
                _playPreviousAudio();
              },
            ),*/
            SizedBox(width: 15,),
             //backward button
                IconButton(
                  icon: Icon(CupertinoIcons.backward_fill),
               
                  onPressed: () {
                    audioPlayer.seekBy(Duration(seconds: -30));
                  },
                ),
                SizedBox(width: 15),
                //play pause button
                GestureDetector(
                  onTap: () {
                    AnimateIcon();
                  },
                  child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: iconController,
                    size: 50,
                    color: Colors.red,
                  ),
                ),
                SizedBox(width:15),
                //forward button
                IconButton(
                 icon: Icon(CupertinoIcons.forward_fill),
                  onPressed: () {
                     audioPlayer.seekBy(Duration(seconds: 30));
                  },
                ),
                SizedBox(width: 15,),

           
                //next button
            /*     IconButton(
                  icon: Icon(Icons.skip_next),
              onPressed: () {
                _playNextAudio();
              },
            ),*/
              ],
            ),
            SizedBox(height: 30,),
            Row(children: [
              SizedBox(width: 20,),
            IconButton(
              onPressed: (){},
              icon :Icon(Icons.volume_down_outlined),

            ),
                    Slider(
                     value: _volume,
              onChanged: (newValue) {
                setState(() {
                  _volume = newValue;
                });
                audioPlayer.setVolume(_volume);
              },
              min: 0.0,
              max: 1.0,
              activeColor: Colors.lightGreen,
              inactiveColor: Colors.grey,
            ),
            ]
            )
          ],
        ),
      ),
    );
  }
//animation icon  for play/pause
  void AnimateIcon() {
    setState(() {
      isAnimated = !isAnimated;

      if (isAnimated) {
        iconController.forward();
        audioPlayer.play();
      } else {
        iconController.reverse();
        audioPlayer.pause();
      }
    });
  }

  @override
  void dispose() {
    iconController.dispose();
    audioPlayer.dispose();
    super.dispose();
  }
}
