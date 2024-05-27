import 'package:appd2fp/sentiment.dart';
import 'package:appd2fp/service.dart';
import 'package:appd2fp/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huggingface_dart/huggingface_dart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class sentimentanalysis extends StatefulWidget {
  final String username;
  // const sentimentanalysis({super.key});
  sentimentanalysis({required this.username});
  @override
  State<sentimentanalysis> createState() => _sentimentanalysisState();
}

class _sentimentanalysisState extends State<sentimentanalysis> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _sentimentController = TextEditingController();
  String _outputText = '';
  late HfInference _hfInference;
  late List<SentimentData> data;
  late TooltipBehavior _tooltip;
  @override
  void initState() {
    data = [];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
    super.initState();
    _hfInference = HfInference('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');
  }

  List<SentimentData> sentimentDataList = [];

  final _formKey = GlobalKey<FormState>();

  Future<void> sentimentAnalysis() async {
    final inputText = _inputController.text;

    if (inputText.isNotEmpty) {
      try {
        final result = await _hfInference.textClassification(
            inputs: inputText, model: 'ElKulako/cryptobert');
        setState(() {
          if (result.isNotEmpty && result[0] is List) {
            sentimentDataList.clear();
            for (var item in result[0]) {
              if (item is Map &&
                  item['label'] is String &&
                  item['score'] is double) {
                sentimentDataList
                    .add(SentimentData(item['label'], item['score']));
              } else {
                print('Unexpected item format: $item');
              }
            }
            SentimentData highestSentiment = sentimentDataList.reduce(
                (current, next) => current.score > next.score ? current : next);
            _sentimentController.text = highestSentiment.sentiment;
            print(_sentimentController.text);
            _outputText = sentimentDataList
                .map((data) => '${data.sentiment}: ${data.score.toString()}')
                .join(', ');

            SentimentAnalysis sentiment = SentimentAnalysis(
              text: _inputController.text,
              sentiment: _sentimentController.text,
            );
            print("user: ${widget.username}");
            // print(_sentimentController.text);
            _postsentiment(sentiment); // Calling async function
          } else {
            _outputText = 'No data available or unexpected response format';
            print('Unexpected result format: $result');
          }
        });
      } catch (error) {
        print('Sentiment Analysis error: $error');
      }
    }
  }

  void _postsentiment(SentimentAnalysis sent) async {
    try {
      await ApiService().createSentimentAnalysis(widget.username, sent);
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('posted successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to post')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            'Enter  your own text',
            style: GoogleFonts.inter(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 183,
            width: 707,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black
                    .withOpacity(0.3), // Black color with 30% visibility
                width: 0, // Border stroke width
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                  16.0), // Optional: add padding inside the container
              child: TextFormField(
                controller: _inputController,
                decoration: InputDecoration(
                  hintText:
                      'This is the best cryptocurrency-text sentiment analyzer ever!',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF424242),
                  ),
                  border: InputBorder.none, // No border for the text field
                ),
                maxLines: null, // Allow multiple lines of input
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 189,
            height: 40,
            child: Material(
              elevation: 10,
              shadowColor: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xFF176BCE),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: sentimentAnalysis,
                child: Text("Analyze",
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    )),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Results',
            style: GoogleFonts.inter(
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          Container(
              height: 120,
              width: 707,
              child: SfCartesianChart(
                  primaryXAxis:
                      CategoryAxis(majorGridLines: MajorGridLines(width: 0)),
                  primaryYAxis: NumericAxis(
                      minimum: 0,
                      maximum: 1,
                      interval: 0.1,
                      majorGridLines: MajorGridLines(width: 0)),
                  tooltipBehavior: _tooltip,
                  series: <CartesianSeries<SentimentData, String>>[
                    BarSeries<SentimentData, String>(
                      dataSource: sentimentDataList,
                      xValueMapper: (SentimentData data, _) => data.sentiment,
                      yValueMapper: (SentimentData data, _) => data.score,
                      name: 'cryptoBERT',
                      pointColorMapper: (SentimentData data, _) =>
                          getColor(data.sentiment),
                    )
                  ]))
        ]);
  }
}

class SentimentData {
  SentimentData(this.sentiment, this.score);

  final String sentiment;
  final double score;
}

// Function to get color based on sentiment
Color getColor(String sentiment) {
  switch (sentiment) {
    case 'Bullish':
      return Colors.green;
    case 'Neutral':
      return Colors.yellow;
    case 'Bearish':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
