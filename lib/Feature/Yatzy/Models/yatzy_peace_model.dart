import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class YatzyPeaceModel extends PeaceModel {
  YatzyPeaceModel({
    required super.id,
    required super.currentStatuses,
    this.gamerId = 0,
    this.isSelected = false,
    this.score = 0,
    this.calculatedScore = 0,
  });

  int gamerId;
  int score;
  bool isSelected;
  int calculatedScore;

  YatzyPeaceModel changeSelectedUser({
    required int score,
  }) {
    return YatzyPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      gamerId: gamerId,
      isSelected: true,
      score: score,
      calculatedScore: calculatedScore,
    );
  }

  YatzyPeaceModel changeCalculatedScore({
    required int newScore,
  }) {
    return YatzyPeaceModel(
      id: id,
      currentStatuses: currentStatuses,
      gamerId: gamerId,
      isSelected: isSelected,
      score: score,
      calculatedScore: newScore,
    );
  }

  @override
  YatzyPeaceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return YatzyPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      gamerId: gamerId,
      isSelected: isSelected,
      score: score,
      calculatedScore: calculatedScore,
    );
  }

  @override
  YatzyPeaceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return YatzyPeaceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      gamerId: gamerId,
      isSelected: isSelected,
      score: score,
      calculatedScore: calculatedScore,
    );
  }
}
