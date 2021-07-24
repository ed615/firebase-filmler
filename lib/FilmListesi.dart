import 'package:dort_filmler_firebase/DetaySayfa.dart';
import 'package:dort_filmler_firebase/Filmler.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Kategoriler.dart';

class FilmListesi extends StatefulWidget {
  Kategoriler? kategori;
  FilmListesi({required this.kategori});
  @override
  _FilmListesiState createState() => _FilmListesiState();
}

class _FilmListesiState extends State<FilmListesi> {

  var refFilmler = FirebaseDatabase.instance.reference().child("filmler");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.kategori!.kategori_ad} Türündeki Filmler"),
      ),
      body: StreamBuilder<Event?>(
        stream:refFilmler.orderByChild("kategori_ad").equalTo(widget.kategori!.kategori_ad).onValue ,
        builder: (context,event){
          if(event.hasData){
            var filmListesi = <Filmler>[];
            var gelenDegerler = event.data!.snapshot.value;

            if(gelenDegerler!= null){
              gelenDegerler.forEach((key,nesne){
                  Filmler gelenFilm = Filmler.fromJson(key,nesne);
                  filmListesi.add(gelenFilm);
              });
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3/5,
                ),
              itemCount: filmListesi.length,
              itemBuilder: (context,indeks){
               var film = filmListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> DetaySayfa(film:film)));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Image.network("http://kasimadalan.pe.hu/filmler/resimler/${film.film_gorsel}"),
                        ),
                        Text("${film.film_ad}",style:TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                      )
                    ),
                );
              },
            );
          }else{return Container();}
        }
        )
    );
  }
}

