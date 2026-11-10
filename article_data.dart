// lib/data/article_data.dart

class Article {
  final String id;
  final String title;
  final String category;
  final String readTime;
  final String summary;
  final String content;

  const Article({
    required this.id,
    required this.title,
    required this.category,
    required this.readTime,
    required this.summary,
    required this.content,
  });
}

class ArticleRepository {
  static const List<Article> articles = [
    Article(
      id: "1",
      title: "First Trimester Nutrition Guide",
      category: "Nutrition",
      readTime: "4 min read",
      summary: "Essential vitamins, foods to focus on, and dietary adjustments to support your early pregnancy development.",
      content: "During the first trimester, your body undergoes significant hormonal and structural shifts. Key adjustments to focus on include:\n\n"
               "• Folic Acid: Crucial for neural tube development. Ensure you take your prenatal vitamins daily.\n"
               "• Hydration: Drink plenty of water to manage blood volume increases and reduce early fatigue.\n"
               "• Small, Frequent Meals: Helps mitigate symptoms of morning sickness and maintains steady blood sugar levels.\n"
               "• Lean Proteins: Prioritize fully cooked poultry, lean meats, and pasteurized low-mercury fish.",
    ),
    Article(
      id: "2",
      title: "Prenatal Warning Signs: When to Call Your Doctor",
      category: "Safety",
      readTime: "5 min read",
      summary: "Understand critical red-flag symptoms during the second and third trimesters that require immediate medical attention.",
      content: "While many body changes are normal, certain severe symptoms mean you should seek medical help right away:\n\n"
               "• Severe Swelling: Sudden or extreme swelling in your hands, face, or ankles can be a warning sign of preeclampsia.\n"
               "• Sudden Decreased Fetal Movement: If you notice a sharp drop in your baby's kicks or movements, contact your clinic immediately.\n"
               "• Vaginal Bleeding or Fluid Leakage: Any continuous fluid loss or bright red bleeding requires prompt clinical evaluation.\n"
               "• Severe Persistent Headaches: Headaches that don't go away after taking approved medication or resting.",
    ),
    Article(
      id: "3",
      title: "Staying Active Safely: Second Trimester Workouts",
      category: "Fitness",
      readTime: "3 min read",
      summary: "Safe, low-impact exercise strategies to improve your energy, sleep quality, and physical resilience.",
      content: "The second trimester often brings a welcome boost in energy. Use this window to stay mobile safely:\n\n"
               "• Low-Impact Cardio: Swimming, prenatal yoga, and brisk walking are excellent ways to maintain strength without stressing your joints.\n"
               "• Core and Pelvic Floor: Incorporate gentle core stabilization movements and Kegel exercises to support birth preparation.\n"
               "• What to Avoid: Stay away from heavy contact sports, lying completely flat on your back for prolonged periods, or overexertion.",
    ),
  ];
}