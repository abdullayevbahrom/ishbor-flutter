class CommonQueryParams {
  final int? pageNumber;
  final int? pageSize;
  final String? id;

  CommonQueryParams({this.pageNumber, this.pageSize, this.id});

  Map<String, dynamic> toMap() {
    return {
      if (pageSize != null) 'size': pageSize,
      if (pageNumber != null) 'page': pageNumber,
    };
  }
}
