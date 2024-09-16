import 'package:flutter/material.dart';

List<Map<String,dynamic>> myTransactionData = [
  {
    "color" : Colors.yellow[700],
    "icon": const Icon(Icons.food_bank,color: Colors.white,),
    "name" : "Food",
    "totalAmount" : "-\$45.00",
    "date" : "Today"
  },
  {
    "color" : Colors.purple,
    "icon": const Icon(Icons.shopping_basket,color: Colors.white),
    "name" : "Shopping",
    "totalAmount" : "-\$50.00",
    "date" : "Today"
  },
  {
    "color" : Colors.green,
    "icon": const Icon(Icons.health_and_safety,color: Colors.white),
    "name" : "Health",
    "totalAmount" : "-\$65.00",
    "date" : "Yesterday"
  },
  {
    "color" : Colors.blue,
    "icon": const Icon(Icons.train_sharp,color: Colors.white),
    "name" : "Travel",
    "totalAmount" : "-\$55.00",
    "date" : "Yesterday"
  }
] ;