class Avatar {
  String name = 'Nina';
  String body = 'assets/body1.png';
  String face = 'assets/face1.png';
  String hair = 'assets/hair1.png';
  List<String> accessoires;

  Avatar({
    this.name,
    this.body,
    this.face,
    this.hair,
  });

  operator [](String type) {
    switch (type) {
      case 'name':
        return name;
      case 'body':
        return body;
      case 'face':
        return face;
      case 'hair':
        return hair;
    }
  }

  operator []=(String key, String value) {
    switch (key) {
      case 'name':
        name = value;
        break;
      case 'body':
        body = value;
        break;
      case 'face':
        face = value;
        break;
      case 'hair':
        hair = value;
        break;
    }
  }
}
