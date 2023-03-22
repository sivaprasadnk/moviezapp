import 'package:moviezapp/provider/app.provider.dart';
import 'package:moviezapp/provider/auth.provider.dart';
import 'package:moviezapp/provider/movies.provider.dart';
import 'package:moviezapp/provider/user.provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<MoviesProvider>(
    create: (_) => MoviesProvider(),
  ),
  ChangeNotifierProvider<AppProvider>(
    create: (_) => AppProvider(),
  ),
  ChangeNotifierProvider<AuthProvider>(
    create: (_) => AuthProvider(),
  ),
  ChangeNotifierProvider<UserProvider>(
    create: (_) => UserProvider(),
  ),
 

];
