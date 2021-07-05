// import 'package:flutter/material.dart';
// import 'package:grocery/widgets/api.dart';
// import 'package:grocery/widgets/response.dart';

// import 'data.dart';

// class ApiHome extends StatefulWidget {
//   @override
//   _ApiHomeState createState() => _ApiHomeState();
// }

// class _ApiHomeState extends State<ApiHome> {
//   ApiServiceProvider _apiServiceProvider = new ApiServiceProvider();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("User List"),
//         ),
//         body: FutureBuilder<Response>(
//           future: _apiServiceProvider.getUser(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               List<Data> list = snapshot.data.result_array;
//               return ListView.builder(
//                   itemCount: list.length,
//                   itemBuilder: (context, index) {
//                     Data user = list[index];
//                     return ListTile(
//                       title: Text(user.name),
//                       // subtitle: Text(user.actual_price),
//                       leading: CircleAvatar(
//                         backgroundImage: NetworkImage(user.img_product),
//                       ),
//                     );
//                   });
//             } else {
//               return Center(child: CircularProgressIndicator());
//             }
//           },
//         ));
//   }
// }
