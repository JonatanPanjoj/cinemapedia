import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  

  Stream<String> getLoadingMessages(){
    const  messages = <String>[
      'Cargando películas...',
      'Comprando palomitas...',
      'Cargando populares...',
      'Llamando a mi novia...',
      'Espera un poco...',
      'Un poquito más...',
      'Esto está tardando más de lo esperado :(',
    ];

    return Stream.periodic(const Duration(milliseconds: 3000), (step){
      return messages[step];
    }).take(messages.length);
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(strokeWidth: 2,),
          const SizedBox(height: 10,),
          StreamBuilder(
            stream: getLoadingMessages(),
            builder:(context, snapshot) {
              if( !snapshot.hasData ) return const Text('Cargando...');
              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}