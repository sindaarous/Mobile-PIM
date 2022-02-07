import 'package:flutter/material.dart';



class ProductInfo extends StatelessWidget {
  final String id;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String age;
  final String phone;
  final String birthday;
  final String gender;
  final String situationF;



  const ProductInfo(
    this.id,
      this.firstname,
      this.lastname,
      this.email,
       this.password,
      this.age,
      this.phone,
      this.birthday,
      this.gender,
      this.situationF,
      
     
      );

  @override
  Widget build(BuildContext context) {
    return Card(
    
       
         /*Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductDetails(type, date);
            },
          ));*/
        
        child: Row(
          children: [
            Text(firstname),
            Text(lastname),
            Text(email),
            Text(password),
            Text(age),
           // Text(id),
          ],
        ),
      
    );
  }
}
