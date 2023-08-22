import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController inputController = TextEditingController();
//   String _text = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Get Input")),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 500,
//               width: double.infinity,
//               child: Placeholder(),
//             ),
//             const SizedBox(
//               height: 100,
//             ),
//             TextField(
//               controller: inputController,
//               decoration: InputDecoration(
//                 hintText: "Enter Data",
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _text = inputController.text;
//                 });
//               },
//               child: const Text(
//                 "Click Me",
//                 style: TextStyle(
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Text(
//               '$_text',
//               style: const TextStyle(
//                 fontSize: 25.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
