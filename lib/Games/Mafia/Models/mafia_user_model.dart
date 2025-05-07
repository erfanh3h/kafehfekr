import 'package:refreshed/refreshed.dart';

class MafiaUserModel {
  MafiaUserModel({
    this.selectedUser,
  });

  int? selectedUser;
  RxString name = RxString("");

  MafiaUserModel changeSelectedUser({
    int? newSelectedUser,
  }) {
    return MafiaUserModel(selectedUser: newSelectedUser);
  }

  MafiaUserModel resetPeace() {
    return MafiaUserModel(selectedUser: null);
  }
}
