//Crio uma classe do meu objeto retornado pelo WebService..
class ObjetoPost {
  int _userID;
  int _id;
  String _title;
  String _body;

  //Construtor
  ObjetoPost(this._userID, this._id, this._title, this._body);

  //Metodo -  vai pegar o valor que está no meu objeto e retornar no formato MAP.
  Map ObjetoToJson() {
    return {
      "userId": this._userID,
      "id": this._id,
      "title": this._title,
      "body": this._body
    };
  }

  String get body => _body;

  set body(String value) {
    _body = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  int get userID => _userID;

  set userID(int value) {
    _userID = value;
  }
}
