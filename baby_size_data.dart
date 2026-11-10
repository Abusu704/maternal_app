// lib/data/baby_size_data.dart

class BabySizeData {
  final String sizeInFruit;
  final String description;

  const BabySizeData({required this.sizeInFruit, required this.description});

  static BabySizeData getWeekData(int week) {
    if (week <= 3) {
      return const BabySizeData(
        sizeInFruit: "a tiny seed",
        description: "Your baby is a blastocyst, newly implanted and rapidly dividing into specialized cells.",
      );
    }
    
    // Map of specific milestone weeks
    final Map<int, BabySizeData> weeklyMap = {
      4: const BabySizeData(sizeInFruit: "a poppy seed", description: "The embryo is forming its structural layers."),
      8: const BabySizeData(sizeInFruit: "a raspberry", description: "Webbed fingers and toes are starting to develop."),
      12: const BabySizeData(sizeInFruit: "a lime", description: "Your baby's kidneys are functioning and reflexes are forming."),
      16: const BabySizeData(sizeInFruit: "an avocado", description: "Eyes and ears are in their proper positions. Baby might be kicking!"),
      20: const BabySizeData(sizeInFruit: "a banana", description: "Halfway there! Your baby is swallowing fluid and actively moving."),
      24: const BabySizeData(sizeInFruit: "an ear of corn", description: "Lungs are starting to develop branches, and skin is becoming less translucent."),
      28: const BabySizeData(sizeInFruit: "an eggplant", description: "Your baby can open and shut their eyes and sense light changes."),
      32: const BabySizeData(sizeInFruit: "a jicama", description: "The skeletal structure is fully formed, but the bones remain soft for birth."),
      36: const BabySizeData(sizeInFruit: "a honeydew melon", description: "Baby is shedding protective coatings and gaining essential fat stores."),
      40: const BabySizeData(sizeInFruit: "a pumpkin", description: "Your baby is fully grown and ready to meet you!"),
    };

    if (weeklyMap.containsKey(week)) {
      return weeklyMap[week]!;
    }

    // Fallback logic to interpolate missing weeks gracefully
    if (week < 8) return const BabySizeData(sizeInFruit: "a blueberry", description: "Essential organs like the heart are forming rapidly.");
    if (week < 12) return const BabySizeData(sizeInFruit: "a strawberry", description: "Baby is moving their limbs, though you can't feel it yet.");
    if (week < 16) return const BabySizeData(sizeInFruit: "an apple", description: "The skeletal system is hardening from cartilage to bone.");
    if (week < 20) return const BabySizeData(sizeInFruit: "a sweet potato", description: "A protective coating called vernix is forming on the skin.");
    if (week < 24) return const BabySizeData(sizeInFruit: "a pomegranate", description: "Taste buds are developing and ears can pick up outside sounds.");
    if (week < 28) return const BabySizeData(sizeInFruit: "a butternut squash", description: "The brain is growing quickly, making pathways for life outside.");
    if (week < 32) return const BabySizeData(sizeInFruit: "a cabbage", description: "The baby is practicing breathing motions using amniotic fluid.");
    
    // FIXED: Changed the colon (:) to a proper closing parenthesis )
    if (week < 36) return const BabySizeData(sizeInFruit: "a cantaloupe", description: "The baby is likely settling into a head-down position for birth.");
    
    return const BabySizeData(sizeInFruit: "a watermelon", description: "Your baby is at full term size and waiting for delivery day.");
  }
}