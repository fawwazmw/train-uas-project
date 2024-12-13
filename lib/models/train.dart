import 'package:flutter/foundation.dart';

@immutable
class Train {
  final String departureTime;
  final String arrivalTime;
  final String from;
  final String to;
  final String duration;
  final String trainName;
  final double price;

  const Train({
    required this.departureTime,
    required this.arrivalTime,
    required this.from,
    required this.to,
    required this.duration,
    required this.trainName,
    required this.price,
  });

  // Method untuk membuat salinan dengan perubahan opsional
  Train copyWith({
    String? departureTime,
    String? arrivalTime,
    String? from,
    String? to,
    String? duration,
    String? trainName,
    double? price,
  }) {
    return Train(
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      from: from ?? this.from,
      to: to ?? this.to,
      duration: duration ?? this.duration,
      trainName: trainName ?? this.trainName,
      price: price ?? this.price,
    );
  }

  // Method untuk mengonversi ke map
  Map<String, dynamic> toMap() {
    return {
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'from': from,
      'to': to,
      'duration': duration,
      'trainName': trainName,
      'price': price,
    };
  }

  // Method factory untuk membuat objek dari map
  factory Train.fromMap(Map<String, dynamic> map) {
    return Train(
      departureTime: map['departureTime'] ?? '',
      arrivalTime: map['arrivalTime'] ?? '',
      from: map['from'] ?? '',
      to: map['to'] ?? '',
      duration: map['duration'] ?? '',
      trainName: map['trainName'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // Metode untuk mendapatkan harga dalam format mata uang
  String get formattedPrice {
    return 'Rp ${price.toStringAsFixed(2)}';
  }

  @override
  String toString() {
    return 'Train(name: $trainName, from: $from, to: $to, price: $formattedPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Train &&
        other.departureTime == departureTime &&
        other.arrivalTime == arrivalTime &&
        other.from == from &&
        other.to == to &&
        other.trainName == trainName;
  }

  @override
  int get hashCode {
    return departureTime.hashCode ^
    arrivalTime.hashCode ^
    from.hashCode ^
    to.hashCode ^
    trainName.hashCode;
  }
}

// Daftar kereta yang sudah ada
final List<Train> trainList = [
  const Train(
    departureTime: '01:30',
    arrivalTime: '02:30',
    from: 'MLG',
    to: 'SBY',
    duration: '1 Jam',
    trainName: 'WAG 7',
    price: 50000.0,
  ),
  const Train(
    departureTime: '09:50',
    arrivalTime: '10:50',
    from: 'MLG',
    to: 'SBY',
    duration: '1 Jam',
    trainName: 'WAG 12B',
    price: 55000.0,
  ),
];

// Fungsi untuk menambah kereta
void addTrain(Train newTrain) {
  trainList.add(newTrain);
}