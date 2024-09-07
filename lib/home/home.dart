import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../../component/import_app.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.onLogout});

  final Function() onLogout;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('My Dictionary',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey)),
          actions: [
            IconButtonApp(
              title: 'Save',
              icon: Icons.save_outlined,
              width: 140,
              height: 40,
              onPressed: () {},
            ),
            const SizedBox(width: 20),
            IconButtonApp(
              title: 'Logout',
              icon: Icons.logout,
              width: 140,
              height: 40,
              bgColor: Colors.white,
              textColor: Colors.blueGrey,
              onPressed: () {
                widget.onLogout();
              },
            ),
            const SizedBox(width: 40)
          ]),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Container(),
          Container(),
          Container(),
          Container(),
        ],
      ),
      bottomSheet: ConvexAppBar(
        height: 70,
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 176, 166, 190),
            Color.fromARGB(255, 148, 159, 163)
          ],
          stops: [0, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        shadowColor: Colors.grey,
        color: Colors.black.withOpacity(0.6),
        activeColor: Colors.blueGrey,
        backgroundColor: Colors.white,
        items: const [
          TabItem(icon: Icons.abc, title: 'New Word'),
          TabItem(icon: Icons.book, title: 'Grammar'),
          TabItem(icon: Icons.sports_esports, title: 'Game'),
          TabItem(icon: Icons.settings, title: 'Setting'),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
