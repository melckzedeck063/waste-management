import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateCard extends StatefulWidget {
  final String title;
  final String description;
  final String pageUrl;

  const UpdateCard({
    Key? key,
    required this.title,
    required this.description,
    required this.pageUrl
  }) : super(key: key);

  @override
  _UpdateCardState createState() => _UpdateCardState();
}

class _UpdateCardState extends State<UpdateCard> {
  bool _showFullDescription = false;
  final String _link = 'https://example.com';

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 3),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _showFullDescription = !_showFullDescription;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              _showFullDescription
                  ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    TextSpan(
                      text: ' For more info, visit: ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    TextSpan(
                      text: widget.pageUrl,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          if (await canLaunch(widget.pageUrl)) {
                            await launch(widget.pageUrl);
                          }
                        },
                    ),
                  ],
                ),
              )
                  : Text(
                _truncateDescription(widget.description),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 10),
              if (!_showFullDescription)
                Text(
                  'Read more',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: Colors.blue[500],
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _truncateDescription(String description) {
    const maxLength = 60;
    return description.length > maxLength
        ? '${description.substring(0, maxLength)}...'
        : description;
  }
}
