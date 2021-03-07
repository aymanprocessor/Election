final String tableTodo = 'election';
final String columnId = '_id';
final String columnName = 'name';
final String columnGroup = 'noOfGroup';

class NamaListModel {
  int id;
  String name;
  int group;

  Map<String, Object> toMap() {
    var map = <String, Object>{columnName: name, columnGroup: group};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  NamaListModel(String _name, int _group) {
    this.name = _name;
    this.group = _group;
  }

  NamaListModel.fromMap(Map<String, Object> map) {
    id = map[columnId];
    name = map[columnName];
    group = map[columnGroup];
  }
}
