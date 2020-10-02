import 'package:flutter/material.dart';
import 'package:login_demo/services/auth.dart';
import 'package:music_player/music_player.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  final musicPlayer = MusicPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SOUND FLEX', style: TextStyle(
          color: Colors.lightBlueAccent[400], fontFamily: 'Righteous',
        )),
        backgroundColor: Colors.grey[800],
        elevation: 0.0,
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person,
            color: Colors.white,),
            label: Text('Logout', style: TextStyle(
              color: Colors.white,
            ),),
            onPressed: () async{
              await _auth.signOut();
              musicPlayer.pause();
            },
          )
        ],
      ),
      body: Container(
        //padding: EdgeInsets.all(20.0),
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(height: 50.0),
            Image.network(
              'https://ak.picdn.net/shutterstock/videos/1013663273/thumb/7.jpg',
            ),
            new Center(
              child: Text('Song Preview',
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.lightBlueAccent[400], fontFamily: 'Righteous',
                ),),
            ),
            SizedBox(height: 50.0),
            RaisedButton(
              color: Colors.grey[400],
                onPressed: () => musicPlayer.play(MusicItem(
                trackName: 'Sample',
                albumName: 'Sample Album',
                artistName: 'Sample Artist',
                  url: 'https://goo.gl/5RQjTQ',
                coverUrl: 'https://goo.gl/Wd1yPP',
                duration: Duration(seconds: 255),
              )),
              shape: CircleBorder(),
                padding: EdgeInsets.all(20.0),
                child: Icon(
                  Icons.play_circle_outline,
                )
            ),
             SizedBox(height: 5.0),
             new RaisedButton(
               color: Colors.grey[400],
              onPressed: () => musicPlayer.pause(),
                 shape: CircleBorder(),
                 padding: EdgeInsets.all(20.0),
               child: Icon(
                 Icons.pause_circle_outline,
               )
            ),
        SizedBox(height: 5.0),
        new Center(
          child: Text('Title: Sample Song',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.grey[400],
          ),),
        ),
            new Center(
              child: Text('Artist: N/A',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[400],
                ),),
            ),
          ],
          ),
        ),
      );

  }
}
