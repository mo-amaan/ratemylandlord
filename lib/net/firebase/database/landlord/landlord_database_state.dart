part of 'landlord_database_cubit.dart';


enum HSStatus {loading, loaded, failure}

class LandlordDatabaseState extends Equatable {

  final List<LandLordRecord> landlordsList;
  final HSStatus status;

  LandlordDatabaseState({
    this.status = HSStatus.loading,
    this.landlordsList = const<LandLordRecord> []
  });


  LandlordDatabaseState copyWith( {
    HSStatus? status,
    List<LandLordRecord>? tenantsList,
  })
  {
    return LandlordDatabaseState(
        status: status ?? this.status,
        landlordsList : tenantsList ?? this.landlordsList
    );
  }

  @override
  List<Object> get props => [status, landlordsList];

  @override
  bool? get stringify => true;
}