import 'package:dort_filmler_firebase/FilmListesi.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'Kategoriler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  var refKategoriler = FirebaseDatabase.instance.reference().child("kategoriler");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        
        title: Text("Filmler Uygulaması Firebase"),
      ),
      body: StreamBuilder<Event?>(
        stream: refKategoriler.onValue,
        builder: (context,event){
          if(event.hasData){
            var kategoriListesi = <Kategoriler>[];
            var gelenDegerler = event.data?.snapshot.value;

            if(gelenDegerler!=null){
              gelenDegerler.forEach((key,nesne){
                var gelenKategori = Kategoriler.fromJson(key,nesne);
                kategoriListesi.add(gelenKategori);
              }
              );
              
            }else{}

            return ListView.builder(
              itemCount: kategoriListesi.length,
              itemBuilder: (context,indeks){
               var kategori = kategoriListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> FilmListesi(kategori: kategori)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: SizedBox(
                        height:50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(kategori.kategori_ad),
                          ],
                          ),
                      )
                      ),
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

