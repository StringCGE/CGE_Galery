

import 'package:galeria_string_cge/galeria/GaleryItem.dart';

class GaleryRowItems<T extends GaleryItem>{
  T Function() creaNull;
  int max;
  GaleryRowItems({
    required this.max,
    required this.creaNull,
  });
  List<T> lItem = [];
  bool add(T item){
    if(lItem.length < max){
      lItem.add(item);
      return true;
    }
    return false;
  }
  void addNull(){
    add(creaNull());
  }
  bool isNotEmpty(){
    return lItem.isNotEmpty;
  }
}