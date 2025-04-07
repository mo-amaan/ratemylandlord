part of 'rating_database_cubit.dart';

enum HSStatus {loading, loaded, failure}

class RatingDatabaseState extends Equatable {

  final List<RatingRecord> leaderboard;
  final HSStatus status;

  RatingDatabaseState({
    this.status = HSStatus.loading,
    this.leaderboard = const<RatingRecord> []
  });

  ///generate a new HighScore State from this
  RatingDatabaseState copyWith( {
    HSStatus? status,
    List<RatingRecord>? leaderboard,
  })
  {
    return RatingDatabaseState(
        status: status ?? this.status,
        leaderboard : leaderboard ?? this.leaderboard
    );
  }

  @override
  List<Object> get props => [status, leaderboard];

  @override
  bool? get stringify => true;
}
