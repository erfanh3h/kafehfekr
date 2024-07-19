abstract class GameRepository {
  // Future<ApiResult<bool>> sendReview({
  //   required final ReviewModel reviewData,
  // });
}

class GameRepositoryImp extends GameRepository {
  // @override
  // Future<ApiResult<bool>> sendReview({required ReviewModel reviewData}) async {
  //   final globalController = Get.find<GlobalController>();
  //   if (globalController.userId != null) {
  //     final databases = Databases(globalController.client);
  //     await databases.createDocument(
  //       databaseId: ServerRoutes.databaseId,
  //       collectionId: ServerRoutes.reviewCollectionId,
  //       documentId: ID.unique(),
  //       data: reviewData.toForm(),
  //     );
  //     return ApiResult(resultData: true);
  //   } else {
  //     return ApiResult(resultData: null);
  //   }
  // }
}
