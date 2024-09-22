import 'package:get_storage/get_storage.dart';
import 'package:tuwaiq_project_pulse/utils/box_storage.dart';

import '../model/auth.dart';
import '../model/user/user.dart';

class AuthMgr {
  AuthData? authData;
  List<User> allUsers = [];
  final box = GetStorage();
  final usersKey = 'users';
  final authKey = 'authData';
  static String adminKey =
      'OTZmYjM1YmRmZjQxYWNmMWEwNDQ4NTc0N2JiNDFmMTNkMjk4NTBjMTQ4YzUyNDdkZDY3YTI2NTE1ZDZjOTU4M2Y1NWI0NzkzODMyYzQyYzk4OWJiYTY0ZGQ5Mjc2YWI2OTYxZDRkYWZlZTY5ZjQ1YzIzNjI1Y2I0ODRiZmE4ZTQ3ZWVhNDcyZDg0YzA3YTIyOTNiZDA3NWU2MjMxOTMxZDQyMmI4MmY4NWUzMGI4Yzc2YzU5Y2VmNGFlM2U1YzY0MTQ4Yzc5MjViOTRhOGZmYWY1OTUzYzU5Y2ZjMTJmZjdkZGRlZDNjOTk3NjcxMzY0MjE0NzI0NWYxYTNiM2JhY2IwNjZjYmFjMzJmMmE4ZjcyMDIyZDM0NDcxZDhhNzY4MmE4Nzg3YjZmODM4MTViZTQ0N2QyM2U5N2NmMThiYTNhODhkYTliMDZiNmIwNmI5YjZjYTI0NGY5NzUyMDk3NzA3YjNjY2Q3ODU3NzlkYTFlMzE3YWViMmRmZTU1MzM3MzI2NjBjNGMxM2FiNTNlMTVlZDc1NDVhNjRlODMxYjUzZDk5YmI5NTA4YTM0YjIwM2IwNjY3YzA1MmMwZWY3ODY2MWQyOThiMTQ2YzgwOTQyYzdhMWQ3ZTgxZDczYWNiMDAzNDAwNjYwYjBhZGU4ZGU2MGY4YjA1MGVhZTdjNGE5MmUzYmRkNWU5ZDM3MzBiY2RkNDgyZDE0N2U0N2E0YzhhMmUxYzQwNzQwOTQwOGNlYzc5MTIzMWQzN2QxMzA5Njg3MzBlMDg5ODliMDFjZGUwOTIwYjE1Y2ZlNjZjZDJlMGUxM2ZkYWM1NmJkZGY4MDVjOTFjMDk0ZjVlYTVmNGQyMTQ3NDg3YjVmZWEzZjcxZDA5MWY0MTliMTBjOWRlODc1ZWJjOWQzMGU2MjkzNzNmMzg0MGVhOTBhODlkODUwYzEyYjM2ZDZjNThmZWRlNTZhNjA1YTdlYTUxYmY3ZjJlNmZmNjc0YWJlOTJhMDJkZTNkNjRmNDQ3NDQ0MjQwMjFjMDgxNTMzZDIwN2M4MDlhYWZkNTgxZjFkMjJjZGFhN2M4Mjc2ODAzMGQ1ZjIzNWIzZDc2OGUzNzgxNjcwMGI5NDRhY2JkZjFiNDk2MzhjNGQ1Yzc0Y2ViYTA2YWQ2Mzc3NTYxYTYwYzlkY2IyMzI1OGI0ODA4ODVkZWQ5NmVjY2JkZDQ4MjkxNDllNmU0MzZjY2MyYmIyZWYwYWVkZDgxZDMzZGM0MTM5OTcwMTI0ZmRmMTgyMDdhOWYyNGVhYTU2YjVjNzYyZDE5NWI4OGI1OGE3ZGIxZDgzNjY3ZGFkZTA3OGU1OTliZmIxOGM2M2M3Yzc4M2Y4NjNjNGFjNGI2NGExODIzNmU3M2ViNDYwM2QzNWZkOTFmNWMxOTYwN2UxMzczYWY3Y2I1ZTU4YmRjY2VjNWIxMDEyNzUzZTc4MDAyNzhlMzc3NmJmNzcwNDE3ZWRlM2YwYWY0ZWFiNjRjYmM3ZjY0Zjc4YjQ2NGMwNTRmMjAxZmNiZTY0YzJhMTJmMjQyODI4M2QwMGJjYTIzMDIzYTgxNmViZWUwNTYwN2E3NTA1OGJiMDNkOWM0YWQ1YzczMzU0ZmE5MjQ3ZjlhOGJiY2QwMDE1ZTgzNGQ3ZDc5NjYyYzYwYmJhMjgzNDIyMzlkNGEzMTkyMWFjNjZlZGQ5OTdiNTQwYTQzNmZmOWQzYjNlNmM2M2I4NjFlMzQ4NjM0MjgwYTkwNzEyYTAwZjUwNGZmNjZhMmYzMTU3MzlkNDRkMjJhYmFjMzU1NTNhMTExOGU4NDM5NzM2MWIxNWVlMWVkOTc4YWYzNDIxZWVmN2YzOGRkODcxMjAyNDNmYmQwZGNhOThiZGE0MGJmOGU4MTg1MGZjMmZlOWY4MjNlN2U3MjU4MzZlNjQxZjM2ZWM3YzZjNDcwMTBmM2MxN2I5OTY4M2RiM2E0ZTMwYzBkYmU1ZThlZWExMWQ5NWQ5NzlkZGFmZGZlOTBlODIxMjc4Y2Y0ZTEyZmViMTUxODJhOGFjMWZjZGJhZDk0NTQ4MmY5MmI4Nzc4NjQxYWFkNjE0MzIxNDMxMTY3NzEzNGQ0YjY2YTJjOGFiYjc1ZWNhNDg1MzMyZDYyMmNkMGQwNmFhMmY3MmVkZGYzZjM4YTQ0NmYzMmQ2ODczNjk1M2YyN2ZkMWFkOTI4MzIyNjY0NGZhN2UzMzZlMGM2YWIzMWQ1ZmQ=';

  AuthMgr() {
    fetchData();
  }

  fetchData() async {
    await fetchUsers();
    await loadAuthData();
    print('All users: ${allUsers.length}');
    print('Auth Data: ${authData?.expiresAt.toString()}');
  }

  // Auth Functions

  Future<void> loadAuthData() async {
    if (box.read(authKey) != null) {
      authData = await BoxStorage.readItem<AuthData>(
          key: authKey, fromJson: (json) => AuthData.fromJson(json));
    }
  }

  Future<void> saveAuth({required AuthData newAuth}) async {
    authData = newAuth;
    await BoxStorage.writeItem<AuthData>(
        item: newAuth, key: authKey, toJson: (auth) => auth.toJson());
  }

  Future<void> logOut() async {
    authData = null;
    box.remove(authKey);
  }

  // User Functions

  Future<void> fetchUsers() async {
    try {
      allUsers = await BoxStorage.readItems<User>(
          key: usersKey, fromJson: (json) => User.fromJson(json));
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> saveUserData({required User user}) async {
    bool userExists =
        allUsers.any((existingUser) => existingUser.id == user.id);

    if (!userExists) {
      allUsers.add(user);
      await BoxStorage.writeItems<User>(
        items: allUsers,
        key: usersKey,
        toJson: (user) => user.toJson(),
      );
    }
  }
}
