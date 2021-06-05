import 'package:flutter/material.dart';

class AppData with ChangeNotifier{
int c =0;
List<dynamic>contrey;
List<String>cato;
List<String>arCato;
String market;
List<String>ctogre;
List<dynamic>listImageTradMark = [];
bool like =true;
 int listContry =1;
  conterIndex(int index){
    c= index;
    notifyListeners();
  }
catog(List cto ,arCto){
  cato = cto;
  arCato=arCto;
  notifyListeners();
}

marketFut(String market){
  
  market = market;
  notifyListeners();
}
  cooList(List coo){
contrey = coo;
  notifyListeners();
}

ctogreList(List cto){
  ctogre = cto;
  notifyListeners();
}
  likeProv(bool newLike){
    like= newLike;
    notifyListeners();
  }

listConter(int listCot){
  listContry= listCot;
  notifyListeners();
}
listImageTrad(List list){
  listImageTradMark= list;
  notifyListeners();
}
}