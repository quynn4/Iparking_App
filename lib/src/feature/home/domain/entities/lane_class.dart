class LaneClass {
  final String id;
  final String laneId;
  final int laneType;

  LaneClass({
    required this.id,
    required this.laneId,
    required this.laneType,
  });
}

class ListLaneClass {
  final List<LaneClass> listLane;

  ListLaneClass(this.listLane);
}
