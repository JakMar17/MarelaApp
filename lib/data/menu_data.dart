class MenuItem {
  String menuName;
  String url;

  MenuItem({this.menuName});
  //MenuItem({this.menuName, this.url});
}

List<MenuItem> categoryMenu = [
  MenuItem(menuName: "Avtomatske postaje"),
  MenuItem(menuName: "Sistem Burja"),
  MenuItem(menuName: "Vodotoki"),
  MenuItem(menuName: "Kakovost zraka"),
  MenuItem(menuName: "Vremenska napoved"),
  MenuItem(menuName: "Morje")
];