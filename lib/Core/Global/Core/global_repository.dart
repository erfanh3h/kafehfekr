// import 'package:appwrite/appwrite.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:hive/hive.dart';
// import 'package:kafehfekr/Core/Global/Models/api_result.dart';
// import 'package:kafehfekr/Core/Routes/server_routes.dart';
// import 'package:kafehfekr/Features/days/Models/days.dart';
// import 'package:refreshed/refreshed.dart';

// import '../Controllers/global_controller.dart';

// abstract class GlobalRepository {
//   Future<ApiResult<String?>> uploadFile({
//     required final PlatformFile fileData,
//   });

//   Future<bool?> getIsLightMode();

//   Future<String?> getUserEmail();

//   Future<bool> writeIsLightMode({required final bool data});

//   Future<bool> writeUserEmail({required final String data});

//   Future<bool> logoutRemoveData();
// }

// class GlobalRepositoryImp extends GlobalRepository {
//   @override
//   Future<ApiResult<String?>> uploadFile(
//       {required PlatformFile fileData}) async {
//     final globalController = Get.find<GlobalController>();
//     if (globalController.userId != null) {
//       final storage = Storage(globalController.client);
//       final file = await storage.createFile(
//         bucketId: ServerRoutes.imagesCollectionId,
//         fileId: ID.unique(),
//         file: InputFile.fromBytes(
//           bytes: fileData.bytes!.toList(),
//           filename: fileData.name,
//         ),
//       );
//       return ApiResult(resultData: file.$id);
//     } else {
//       return ApiResult(resultData: null);
//     }
//   }

//   @override
//   Future<bool?> getIsLightMode() async {
//     try {
//       final Box<bool> storage = await Hive.openBox<bool>('isLightMode');
//       final result = storage.values.first;
//       return result;
//     } catch (_) {
//       return null;
//     }
//   }

//   @override
//   Future<bool> writeIsLightMode({required bool data}) async {
//     final Box<bool> storage = await Hive.openBox<bool>('isLightMode');
//     try {
//       await storage.clear();
//     } catch (_) {}
//     await storage.add(data);
//     return true;
//   }

//   @override
//   Future<String?> getUserEmail() async {
//     try {
//       final Box<String> storage = await Hive.openBox<String>('userEmail');
//       final result = storage.values.first;
//       return result;
//     } catch (_) {
//       return null;
//     }
//   }

//   @override
//   Future<bool> writeUserEmail({required String data}) async {
//     final Box<String> storage = await Hive.openBox<String>('userEmail');
//     try {
//       await storage.clear();
//     } catch (_) {}
//     await storage.add(data);
//     return true;
//   }

//   @override
//   Future<bool> logoutRemoveData() async {
//     final storage = await Hive.openBox<String>('userEmail');
//     await storage.clear();
//     await storage.close();
//     final List<int> daysList = [1, 3, 7, 12, 13, 15, 26];
//     for (var day in daysList) {
//       final storage = await Hive.openBox<DaysModel>('days$day');
//       await storage.clear();
//       await storage.close();
//     }
//     return true;
//   }
// }
