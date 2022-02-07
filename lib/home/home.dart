import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'product_info.dart';

Future<User> fetchUser() async {
  String _baseUrl = "localhost:9091";
  Map<String, String> headers = {
    "Content-Type": "application/json; charset=UTF-8"
  };
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> userData = {
    "email": prefs.getString("email"),
  };
  final response = await http.post(Uri.http(_baseUrl, '/api/users/show'),
      headers: headers, body: json.encode(userData));

  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    var userId = res['_id'];
    var usermail = res['email'];
    var userPwd = res['password'];
    var firsrname=res['firstname'];
    var lastname=res['lastname'];
    var age=res['age'];
    var birthday=res['birthday'];
    var phone=res['phone'];
    var gender=res['gender'];
    var situationF=res['situationF'];
    print("resultat$userId");
    print("resultat$usermail");
    print("resultat$userPwd");
    print("resultat$firsrname");
    print("resultat$lastname");
    print("resultat$age");
    print("resultat$phone");
    print("resultat$gender");
    print("resultat$situationF");
    //print(userId);
    prefs.setString("id", userId);
    prefs.setString("email", usermail);
    prefs.setString("password", userPwd);
    prefs.setString("firstname", firsrname);
    prefs.setString("lastname", lastname);
    prefs.setString("age", age);
    prefs.setString("birthday", birthday);
    prefs.setString("phone", phone);
    prefs.setString("gender", gender);
    prefs.setString("situationF", situationF);
    return User.fromJson(jsonDecode(response.body), prefs);
  } else {
    throw Exception('Failed to load user');
  }
}

class User {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String age;
  final String birthday;
  final String phone;
  final String gender;
  final String situationF;
  //final String title;

  const User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.age,
    required this.birthday,
    required this.phone,
    required this.gender,
    required this.situationF,
    //required this.title,
  });

  factory User.fromJson(Map<String, dynamic> json, prefs) {
    //prefs.setString("nom": json['nom']);
    return User(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      age: json['age'],
      birthday: json['birthday'],
      phone: json['phone'],
      gender: json['gender'],
      situationF: json['situationF'],
      // id: json['id'],
      //title: json['title'],
    );
  }
}

void main() => runApp(const Home());

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String? _email;
  late Future<User> futureUser;
  Future<void> insertSharedPrefs(String id) async {
    await SharedPreferences.getInstance().then((prefs) {
      //prefs.setString('email', _email!);
      prefs.setString('id', id);

      // prefs.setString('email', email)
    });
  }

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
           child: FutureBuilder<User>(
          future: futureUser,
          builder: (context, snapshot) {
            
            if (snapshot.hasData) {
              return ProductInfo(
                snapshot.data!.id,
                snapshot.data!.firstname ,
                snapshot.data!.lastname,
                snapshot.data!.email,
                snapshot.data!.password,
                snapshot.data!.age,
                snapshot.data!.phone,
                snapshot.data!.birthday,
                snapshot.data!.gender,
                snapshot.data!.situationF,
                
              );
             
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            
              // By default, show a loading spinner.
            return const CircularProgressIndicator();
            },
          ),
          ),
    );
  }
}







/*class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   late String? _nom;
  late String? _prenom;
  late String? _email;
  late String? _password;
  late String? _code;

     SharedPreferences prefs =  SharedPreferences.getInstance() as SharedPreferences;*/

  //var
  /*String _baseUrl = 'localhost:9091';

  late Future<bool> fetchedGames;
  final List<GameData> _games = [];


  //Actions
  Future<bool> getGames() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
                          //  prefs.setString("code", userData["code"]);
    Map<String, String> headers = {
      "Content-Type":"application/json; charset=UTF-8"
    };
    //Body
    Map<String, dynamic> userData = {
      "code" : prefs.getString("code"),
                     // "password": _password
    };
    http.Response response = await http.post(Uri.http(_baseUrl, "/api/users/show"), headers: headers, body: json.encode(userData));
    print(response.body);
   
   
   // print(prefs.getString("code"));
    
    List<dynamic> gamesFromServer = json.decode(response.body);
    print(gamesFromServer);
    for (var item in gamesFromServer) {
      _games.add(GameData(item['nom']));
    }


    return true;*/
  

  /*@override
  void initState() {
    super.initState();
    fetchedGames = getGames();
  }*/

  /*@override

  Widget build(BuildContext context) {
    return Scaffold(
      //future: fetchedGames,
       appBar: AppBar(
        title: const Text("evax"),
      ),
      
      body:Text(prefs.getString("code").toString()));
        
      //builder: (context, snapshot) {
        //if (snapshot.hasData) {
         // print(_games.length);
           /*ListView.builder(
            itemCount: _games.length,
            itemBuilder: (context, index) {
               SharedPreferences prefs =  SharedPreferences.getInstance() as SharedPreferences;
                            print(prefs.getString("code"));
                            print(prefs.getString("password"));
                            print(prefs.getString("nom"));
                            print(prefs.getString("prenom"));
                            print(prefs.getString("email"));*/
            /*return
            Center(
              child: Text(prefs.getString("code").toString()));*/
            
             //ProductInfo(
              //_games[index].nom,
           /* _games[index].prenom,
            _games[index].code,
            _games[index].email,
            _games[index].password,*/
            
           // _games[index].date,
           // );
          //},);
       // } 
       /*else {
          //print(_games.length);
          return Center(child: Text('vous n avez pris aucune dose'));
        }*/
  //  },);
  }


/* ListView.builder(
      itemCount: _games.length,
      itemBuilder: (BuildContext context, int index) {
        return ProductInfo(
            _games[index].image,
            _games[index].title,
            _games[index].description,
            _games[index].price,
            _games[index].quantity);
      },
    ); */
/*class GameData {
  final String nom;
  /*final String date;
  final Sting*/
  

  GameData(this.nom);

  @override
  String toString() {
    return 'GameData{nom: $nom}';
  }*/
  }
*/
