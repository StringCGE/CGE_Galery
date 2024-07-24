import 'dart:async';

import 'package:flutter/material.dart';
import 'package:galeria_string_cge/db_fotos.dart';
import 'package:galeria_string_cge/galeria/GaleryItem.dart';
import 'package:galeria_string_cge/galeria/galery_widget.dart';


class Galery extends StatefulWidget{
  const Galery({
    super.key,
  });

  @override
  GaleryState createState() => GaleryState();
}

class GaleryState extends State<Galery> {
  late StreamSubscription _subsEstado;

  @override
  void initState() {
    super.initState();
    myInitState();
  }
  void myInitState() {

  }

  @override
  void didUpdateWidget(covariant Galery oldWidget) {
    super.didUpdateWidget(oldWidget);
    myInitState();
  }
  bool compararFechas(DateTime date1, DateTime date2){
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
  DateTime odl = DateTime(0,0,0);
  @override
  Widget build(BuildContext context) {
    return Material(
        child:Scaffold(
          appBar: AppBar(title: Text("CGE Galeria")),
          body:LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                child: GaleryWidgetIntern(
                  backColor: Colors.white,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  imgColumns: 5,
                  itemWid: (GaleryItem item){
                    if(item.isNotNull){
                      return foto(context, item as Foto);
                    }
                    return Container(
                      color: Colors.white,
                    );
                  },
                  fech: (int lastIndex, int countData) {
                    return DbFotos().fetchData(lastIndex, countData);
                  },
                  separador: (GaleryItem item) {
                    Foto f = item as Foto;
                    if(!compararFechas(odl,f.date)){
                      odl = f.date;
                      return separadorDate(f.date);
                    }
                    return null;
                  },
                  notFountData: () => Center( child: Text("No existen fotos")),
                ),
              );
            },
          ),
        )
    );
  }


  @override
  void dispose(){
    _subsEstado?.cancel();
    super.dispose();
  }
  Widget separadorDate(DateTime date){
    return Container(
      padding: EdgeInsets.all(0.0),
      alignment: Alignment.center,
      child: Container(
        color: Colors.black12,
        height: 30,
        child: Center(
          child: Text(
            '${date.year}-${date.month}-${date.day}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
  Widget foto(BuildContext context, Foto foto){
    return Container(
      color: Colors.cyanAccent,
      padding: EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.cyan,
          child: Column(
            children: [
              Text("id: ${foto.id}"),
              Text("${foto.date}"),
            ],
          ),
        )
      )
    );
  }
  final List<Foto> lGaleryItem = [];
}
