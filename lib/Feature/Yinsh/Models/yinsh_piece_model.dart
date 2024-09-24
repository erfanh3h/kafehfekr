import 'package:kafehfekr/Core/Global/Models/peace_model.dart';
import 'package:kafehfekr/Core/Global/Models/global_enums.dart';

class YinshPieceModel extends PeaceModel {
  YinshPieceModel({
    required super.id,
    required super.currentStatuses,
    required this.directions,
    this.selectedDisk,
    this.selectedRing,
  });

  int? selectedDisk;
  int? selectedRing;
  List<(int, int)> directions;

  YinshPieceModel changeDirections({
    required List<(int, int)> newDirections,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return YinshPieceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedDisk: selectedDisk,
      selectedRing: selectedRing,
      directions: newDirections,
    );
  }

  YinshPieceModel changeselectedDisk({
    int? newselectedDisk,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return YinshPieceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedDisk: newselectedDisk,
      selectedRing: selectedRing,
      directions: directions,
    );
  }

  YinshPieceModel changeselectedRing({
    int? newselectedRing,
  }) {
    final data = super.addStatus(status: PeaceStatusTypes.selected);
    return YinshPieceModel(
      id: id,
      currentStatuses: data.currentStatuses,
      selectedRing: newselectedRing,
      selectedDisk: selectedDisk,
      directions: directions,
    );
  }

  YinshPieceModel resetPeace() {
    return YinshPieceModel(
      id: id,
      currentStatuses: [],
      selectedDisk: null,
      selectedRing: null,
      directions: [],
    );
  }

  @override
  YinshPieceModel addStatus({required PeaceStatusTypes status}) {
    final data = super.addStatus(status: status);
    return YinshPieceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedDisk: selectedDisk,
      selectedRing: selectedRing,
      directions: directions,
    );
  }

  @override
  YinshPieceModel removeStatus({required PeaceStatusTypes status}) {
    final data = super.removeStatus(status: status);
    return YinshPieceModel(
      id: data.id,
      currentStatuses: data.currentStatuses,
      selectedDisk: selectedDisk,
      selectedRing: selectedRing,
      directions: directions,
    );
  }
}
