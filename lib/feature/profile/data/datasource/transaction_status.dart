
class TransactionStatus {
  final bool success;
  final Status status;

  const TransactionStatus({
    required this.success,
    required this.status,
  });

  TransactionStatus copyWith({
    bool? success,
    Status? status,
  }) {
    return TransactionStatus(
      success: success ?? this.success,
      status: status ?? this.status,
    );
  }

  factory TransactionStatus.fromJson(Map<String, dynamic> json) {
    return TransactionStatus(
      success: (json['success'] as bool?) ?? false,
      status: StatusX.fromString(json['status'] as String?),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'status': status.toJson(),
  };

  @override
  String toString() => 'OperationStatus(success: $success, status: $status)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TransactionStatus &&
              runtimeType == other.runtimeType &&
              success == other.success &&
              status == other.status;

  @override
  int get hashCode => Object.hash(success, status);
}

enum Status { completed, pending, processing, cancelled }

extension StatusX on Status {
  String toJson() {
    switch (this) {
      case Status.completed:
        return 'completed';
      case Status.pending:
        return 'pending';
      case Status.processing:
        return 'processing';
      case Status.cancelled:
        return 'cancelled';
    }
  }

  static Status fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'completed':
        return Status.completed;
      case 'processing':
        return Status.processing;
      case 'cancelled':
        return Status.cancelled;
      case 'pending':
      default:
        return Status.pending;
    }
  }
}
