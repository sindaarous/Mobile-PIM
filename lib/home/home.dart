import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_sim4/acceuil.dart';
import 'package:workshop_sim4/addR.dart';
import 'package:workshop_sim4/body.dart';
import 'package:workshop_sim4/home/updateProfile.dart';
import '../bodytous.dart';
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
  final response = await http.post(Uri.http(_baseUrl, '/api/patient/show'),
      headers: headers, body: json.encode(userData));

  if (response.statusCode == 200) {
    Map<String, dynamic> res = json.decode(response.body);
    var userId = res['_id'];
    var usermail = res['email'];
    var userPwd = res['password'];
    var firsrname=res['firstname'];
    var lastname=res['lastname'];
    var adresse=res['adresse'];
    var birthday=res['birthday'];
    var phone=res['phone'];
    var GroupeSanguine=res['GroupeSanguine'];
    var situationF=res['situationF'];
    print("resultat$userId");
    print("resultat$usermail");
    print("resultat$userPwd");
    print("resultat$firsrname");
    print("resultat$lastname");
    print("resultat$adresse");
    print("resultat$phone");
    print("resultat$GroupeSanguine");
    print("resultat$situationF");
    //print(userId);
    prefs.setString("id", userId);
    prefs.setString("email", usermail);
    prefs.setString("password", userPwd);
    prefs.setString("firstname", firsrname);
    prefs.setString("lastname", lastname);
    prefs.setString("adresse", adresse);
    prefs.setString("birthday", birthday);
    prefs.setString("phone", phone);
    prefs.setString("GroupeSanguine", GroupeSanguine);
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
  final String adresse;
  final String birthday;
  final String phone;
  final String GroupeSanguine;
  final String situationF;
  //final String title;

  const User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    required this.adresse,
    required this.birthday,
    required this.phone,
    required this.GroupeSanguine,
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
      adresse: json['adresse'],
      birthday: json['birthday'],
      phone: json['phone'],
      GroupeSanguine: json['GroupeSanguine'],
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
   int currentTab = 0;
  final List<Widget> screens = [AddO(), Body(), Home()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Accueil();
  late String? _email;
  late Future<User> futureUser;
  Future<void> insertSharedPrefs(String id) async {
    await SharedPreferences.getInstance().then((prefs) {
      print("here");
      prefs.setString('email', _email!);
      //prefs.setString('id', id);

      // prefs.setString('email', email)
    });
  }

  @override
  void initState() {
    super.initState();
   // futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      
      PageStorage(bucket: bucket, child: currentScreen),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = Accueil();
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: currentTab == 0 ? Colors.green : Colors.grey,
                        ),
                        Text(
                          'Accueil',
                          style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.green : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = BodyTous();
                        currentTab = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_alarms_rounded ,
                          color: currentTab == 1 ? Colors.green : Colors.grey,
                        ),
                        Text(
                          'Rendez-vous',
                          style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.green : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
       /*Center(
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
                snapshot.data!.adresse,
                snapshot.data!.phone,
                snapshot.data!.birthday,
                snapshot.data!.GroupeSanguine,
                snapshot.data!.situationF,
                
              );
             
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            
              // By default, show a loading spinner.
            return const CircularProgressIndicator();
            },
          ),
          ),*/
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
