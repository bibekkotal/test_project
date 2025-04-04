part of 'discover_bloc.dart';

class DiscoverState extends Equatable {
  final int selectedBottomTabIndex;

  DiscoverState({
    required this.selectedBottomTabIndex,
  });

  DiscoverState copyWith({
    int? selectedBottomTabIndex,
  }) {
    return DiscoverState(
      selectedBottomTabIndex:
          selectedBottomTabIndex ?? this.selectedBottomTabIndex,
    );
  }

  @override
  List<Object?> get props => [selectedBottomTabIndex];
}

class PlaceItem {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final num rating;
  final int reviewCount;
  final int guests;
  final int bedrooms;
  final int beds;
  final int bathrooms;
  final num originalPrice;
  final num discountedPrice;
  final num totalPrice;
  final bool isFavorite;

  PlaceItem({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.guests,
    required this.bedrooms,
    required this.beds,
    required this.bathrooms,
    required this.originalPrice,
    required this.discountedPrice,
    required this.totalPrice,
    this.isFavorite = false,
  });

  factory PlaceItem.fromJson(Map<String, dynamic> json) {
    return PlaceItem(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      imageUrl: json['imageUrl'],
      rating: json['rating'],
      reviewCount: json['reviewCount'],
      guests: json['guests'],
      bedrooms: json['bedrooms'],
      beds: json['beds'],
      bathrooms: json['bathrooms'],
      originalPrice: json['originalPrice'],
      discountedPrice: json['discountedPrice'],
      totalPrice: json['totalPrice'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'guests': guests,
      'bedrooms': bedrooms,
      'beds': beds,
      'bathrooms': bathrooms,
      'originalPrice': originalPrice,
      'discountedPrice': discountedPrice,
      'totalPrice': totalPrice,
      'isFavorite': isFavorite,
    };
  }
}

final List<Map<String, dynamic>> placesData = [
  {
    'id': 'p1',
    'name': 'Tiny home in Rælingen',
    'location': 'Rælingen, Norway',
    'imageUrl': AppImages.five,
    'rating': 4.96,
    'reviewCount': 217,
    'guests': 4,
    'bedrooms': 2,
    'beds': 2,
    'bathrooms': 1,
    'originalPrice': 117,
    'discountedPrice': 91,
    'totalPrice': 273,
    'isFavorite': false
  },
  {
    'id': 'p2',
    'name': 'Glass cabin with lake view',
    'location': 'Oslo, Norway',
    'imageUrl': AppImages.four,
    'rating': 4.92,
    'reviewCount': 184,
    'guests': 2,
    'bedrooms': 1,
    'beds': 1,
    'bathrooms': 1,
    'originalPrice': 135,
    'discountedPrice': 120,
    'totalPrice': 360,
    'isFavorite': true
  },
  {
    'id': 'p3',
    'name': 'Coastal cottage in Bergen',
    'location': 'Bergen, Norway',
    'imageUrl': AppImages.six,
    'rating': 4.89,
    'reviewCount': 156,
    'guests': 5,
    'bedrooms': 3,
    'beds': 4,
    'bathrooms': 2,
    'originalPrice': 165,
    'discountedPrice': 149,
    'totalPrice': 447,
    'isFavorite': false
  },
];
