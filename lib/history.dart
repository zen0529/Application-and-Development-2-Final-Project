import 'package:appd2fp/sentiment.dart';
import 'package:appd2fp/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class history extends StatefulWidget {
  final String username;
  history({required this.username});
  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  late String? uid;
  late Future<List<SentimentAnalysis>> _sentimentAnalysisFuture;
  final ApiService _apiService = ApiService();
  @override
  void initState() {
    super.initState();
    _sentimentAnalysisFuture =
        _apiService.fetchSentimentAnalysis(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 100,
        ),
        Text(
          'History',
          style: GoogleFonts.inter(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 500,
          width: 888,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black
                  .withOpacity(0.3), // Black color with 30% visibility
              width: 0, // Border stroke width
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(children: [
            const SizedBox(
              height: 51,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 214,
                ),
                Text(
                  'Text',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF424242),
                  ),
                ),
                const SizedBox(
                  width: 368,
                ),
                Text(
                  'Label',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF424242),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 33,
            ),
            Image.asset('assets/images/historyline.png'),
            Expanded(
              child: FutureBuilder<List<SentimentAnalysis>>(
                future: _sentimentAnalysisFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Failed to load sentiment analysis'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No sentiment analysis found'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        SentimentAnalysis analysis = snapshot.data![index];
                        return Column(children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 116,
                              ),
                              Container(
                                width: 469,
                                height: 25,
                                child: Text(
                                  analysis.text,
                                  style: GoogleFonts.inter(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: const Color(0xFF424242),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Text(
                                analysis.sentiment,
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  color: const Color(0xFF424242),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset('assets/images/historyline.png'),
                        ]);
                      },
                    );
                  }
                },
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
