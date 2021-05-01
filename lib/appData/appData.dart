import 'package:flutter/material.dart';

class AppData with ChangeNotifier{
int c =0;
List<dynamic>contrey;
List<dynamic>listImageTradMark = [];
bool like =true;
 int listContry =1;
  conterIndex(int index){
    c= index;
    notifyListeners();
  }
cooList(List coo){
contrey = coo;
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