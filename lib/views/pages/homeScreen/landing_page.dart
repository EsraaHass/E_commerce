// class LandingPage extends StatelessWidget {
//   static const String routeName = 'LandingPage';
//
//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthBase>(context);
//     return StreamBuilder<MyUser?>(
//         stream: auth.authStatesChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             final user = snapshot.data;
//             if (user == null) {
//              // SharedData.id = user?.uid;
//               return ChangeNotifierProvider(
//                   create: (_) => LoginViewModel(authBase: auth),
//                   child: Login());
//             }
//             return Provider(
//                 create: (_) => DatabaseViewModel(uid: user.id),
//                 child: BottomNaveBar());
//           }
//           return const Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         });
//   }
//
// }
