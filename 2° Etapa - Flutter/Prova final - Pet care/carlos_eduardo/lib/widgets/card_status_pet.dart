import 'package:flutter/material.dart';
void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Status(),
    );
  }
}

class Status extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Text(
                  'nome do responsável:',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                   SizedBox(height: 12),

                Text(
                  'telefone',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'Nome do pet: ',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'Energia atual',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'Fome atual',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),  
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

