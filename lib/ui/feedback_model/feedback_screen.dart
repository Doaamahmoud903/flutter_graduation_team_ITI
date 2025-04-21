import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackScreen extends StatefulWidget {
  static const String routeName = 'FeedbackScreen';

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  // إرسال الملاحظات إلى API
  Future<void> _submitFeedback() async {
    final text = _controller.text;

    // إرسال النص إلى السيرفر
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/analyze'), // تم تصحيح الرابط هنا
      headers: {"Content-Type": "application/json"},
      body: json.encode({"text": text}),
    );

    if (response.statusCode == 200) {
      // لو حصل استجابة صحيحة، هنعرض النتيجة
      final responseData = json.decode(response.body);
      setState(() {
        _result = "النتيجة: ${responseData['label']}";
      });
    } else {
      setState(() {
        _result = "فشل في إرسال الملاحظات!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('تقييم المنتج'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'اكتب ملاحظاتك'),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitFeedback,
              child: Text('إرسال الملاحظات'),
            ),
            SizedBox(height: 16),
            Text(_result), // عرض النتيجة (إيجابي أو سلبي)
          ],
        ),
      ),
    );
  }
}
