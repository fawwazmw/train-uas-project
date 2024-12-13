import 'package:flutter/foundation.dart';

@immutable
class TransactionModel {
  final String ticketCode;
  final double ticketPrice;
  final String paymentMethod;
  final DateTime transactionDate;
  final String fromStation;
  final String toStation;
  final String trainName;

  const TransactionModel({
    required this.ticketCode,
    required this.ticketPrice,
    required this.paymentMethod,
    required this.transactionDate,
    this.fromStation = '',
    this.toStation = '',
    this.trainName = '',
  });

  // Method untuk membuat salinan dengan perubahan opsional
  TransactionModel copyWith({
    String? ticketCode,
    double? ticketPrice,
    String? paymentMethod,
    DateTime? transactionDate,
    String? fromStation,
    String? toStation,
    String? trainName,
  }) {
    return TransactionModel(
      ticketCode: ticketCode ?? this.ticketCode,
      ticketPrice: ticketPrice ?? this.ticketPrice,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      transactionDate: transactionDate ?? this.transactionDate,
      fromStation: fromStation ?? this.fromStation,
      toStation: toStation ?? this.toStation,
      trainName: trainName ?? this.trainName,
    );
  }

  // Method untuk mengonversi ke map
  Map<String, dynamic> toMap() {
    return {
      'ticketCode': ticketCode,
      'ticketPrice': ticketPrice,
      'paymentMethod': paymentMethod,
      'transactionDate': transactionDate.toIso8601String(),
      'fromStation': fromStation,
      'toStation': toStation,
      'trainName': trainName,
    };
  }

  // Method factory untuk membuat objek dari map
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      ticketCode: map['ticketCode'] ?? '',
      ticketPrice: (map['ticketPrice'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: map['paymentMethod'] ?? '',
      transactionDate: map['transactionDate'] != null
          ? DateTime.parse(map['transactionDate'])
          : DateTime.now(),
      fromStation: map['fromStation'] ?? '',
      toStation: map['toStation'] ?? '',
      trainName: map['trainName'] ?? '',
    );
  }

  // Metode untuk mendapatkan total harga dalam format mata uang
  String get formattedPrice {
    return 'Rp ${ticketPrice.toStringAsFixed(2)}';
  }

  @override
  String toString() {
    return 'TransactionModel(ticketCode: $ticketCode, price: $formattedPrice, method: $paymentMethod)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TransactionModel &&
        other.ticketCode == ticketCode &&
        other.ticketPrice == ticketPrice &&
        other.paymentMethod == paymentMethod &&
        other.transactionDate == transactionDate;
  }

  @override
  int get hashCode {
    return ticketCode.hashCode ^
    ticketPrice.hashCode ^
    paymentMethod.hashCode ^
    transactionDate.hashCode;
  }
}