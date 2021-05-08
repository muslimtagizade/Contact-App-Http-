import 'package:flutter/material.dart';
import 'package:kisiler_uygulamasi/Kisiler.dart';
import 'package:kisiler_uygulamasi/main.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class KisiDetaySayfa extends StatefulWidget {
  Kisiler kisi;

  KisiDetaySayfa({this.kisi});

  @override
  _KisiDetaySayfaState createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  Future<void> guncelle(int kisi_id,String kisi_ad,String kisi_tel) async {
    var url = "http://kasimadalan.pe.hu/kisiler/update_kisiler.php";
    var veri = {"kisi_id":kisi_id.toString(),"kisi_ad":kisi_ad,"kisi_tel":kisi_tel};
    var cevap = await http.post(url,body: veri);
    print("Güncelle cevap : ${cevap.body}");
    Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAdi.text = kisi.kisi_ad;
    tfKisiTel.text = kisi.kisi_tel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi Detay"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50,right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfKisiAdi,
                decoration: InputDecoration(hintText: "Kişi Ad"),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: InputDecoration(hintText: "Kişi Tel"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          guncelle(int.parse(widget.kisi.kisi_id), tfKisiAdi.text, tfKisiTel.text);
        },
        tooltip: 'Kişi Güncelle',
        icon: Icon(Icons.update),
        label: Text("Güncelle"),
      ),
    );
  }
}
