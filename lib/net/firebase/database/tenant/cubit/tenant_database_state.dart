
part of 'tenant_database_cubit.dart';

enum HSStatus {loading, loaded, failure}

class TenantsDatabaseState extends Equatable {

  final List<TenantRecord> tenantsList;
  final HSStatus status;

  TenantsDatabaseState({
    this.status = HSStatus.loading,
    this.tenantsList = const<TenantRecord> []
  });


  TenantsDatabaseState copyWith( {
    HSStatus? status,
    List<TenantRecord>? tenantsList,
  })
  {
    return TenantsDatabaseState(
        status: status ?? this.status,
        tenantsList : tenantsList ?? this.tenantsList
    );
  }

  @override
  List<Object> get props => [status, tenantsList];

  @override
  bool? get stringify => true;
}
