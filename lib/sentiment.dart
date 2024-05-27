class SentimentAnalysis {
  String text;
  String sentiment;

  SentimentAnalysis({required this.text, required this.sentiment});

  factory SentimentAnalysis.fromJson(Map<String, dynamic> json) {
    return SentimentAnalysis(
      text: json['text'],
      sentiment: json['sentiment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sentiment': sentiment,
    };
  }
}
