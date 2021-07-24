import 'package:flutter/material.dart';

import 'Filmler.dart';

class DetaySayfa extends StatefulWidget {
  Filmler? film; 

  DetaySayfa({required this.film});

  @override
  _DetaySayfaState createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        
        title: Text("${widget.film!.film_ad}"),
      ),
      body: Center(
        
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

         children: [
            Image.network("http://kasimadalan.pe.hu/filmler/resimler/${widget.film?.film_gorsel}"),
            Text("${widget.film!.film_yil}",style:TextStyle(fontSize: 30, fontWeight:FontWeight.bold ),),
            Text("${widget.film!.yonetmen_ad}",style:TextStyle(fontSize: 25, fontWeight:FontWeight.bold ),),
            ],)
        ),
    );
  }
}