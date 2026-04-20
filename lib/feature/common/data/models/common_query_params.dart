class CommonQueryParams {
  final int? pageNumber;
  final int? pageSize;
  final int? id;

  CommonQueryParams({this.pageNumber, this.pageSize, this.id});

  Map<String, dynamic> toMap() {
    return {
      if (pageSize != null) 'size': pageSize,
      if (pageNumber != null) 'page': pageNumber,
    };
  }
}
