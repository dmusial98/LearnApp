import 'package:flutter/material.dart';

class MenuBottom extends StatelessWidget {
  const MenuBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/');
            break;
          case 1:
            Navigator.pushNamed(context, '/search');
            break;
          case 2:
            Navigator.pushNamed(context, '/explore');
            break;
          case 3:
            Navigator.pushNamed(context, '/add');
            break;
          case 4:
            Navigator.pushNamed(context, '/favourites');
            break;
          default:
        }
      },
      type: BottomNavigationBarType.fixed,
      //backgroundColor: const Color(0x00000000),
      fixedColor: Colors.black,
      unselectedItemColor: Colors.black,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Own'
        ),
        const BottomNavigationBarItem( // alt+shift=strzalka_w_dol duplikuje zaznaczenie i wstawia na dol
          icon: Icon(Icons.search),
          label: 'Search'
        ),
        const BottomNavigationBarItem( // alt+shift=strzalka_w_dol duplikuje zaznaczenie i wstawia na dol
          icon: Icon(Icons.language),
          label: 'Explore'
        ),
        const BottomNavigationBarItem( // alt+shift=strzalka_w_dol duplikuje zaznaczenie i wstawia na dol
          icon: Icon(Icons.add),
          label: 'Add'
        ),
        const BottomNavigationBarItem( // alt+shift=strzalka_w_dol duplikuje zaznaczenie i wstawia na dol
          icon: Icon(Icons.star),
          label: 'Favourites'
        )
    ]);
  }
}