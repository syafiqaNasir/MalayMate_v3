import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:malaymate/Controller/image_controller.dart';
import 'package:dotted_border/dotted_border.dart';

class TranslateWithCameraPage extends StatefulWidget {
  final String title;

  const TranslateWithCameraPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _TranslateWithCameraPageState createState() => _TranslateWithCameraPageState();
}

class _TranslateWithCameraPageState extends State<TranslateWithCameraPage> {
  final ImageController _controller = ImageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _body()),
        ],
      ),
    );
  }

  Widget _body() {
    return ValueListenableBuilder(
      valueListenable: _controller.imageNotifier,
      builder: (context, image, child) {
        if (image != null) {
          return _imageCard();
        } else {
          return _uploaderCard();
        }
      },
    );
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
          const SizedBox(height: 20),
          _languageSelection(),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () async {
                await _controller.performOCR();
                _controller.translateText();
              },
              child: const Text('Translate Image')
          ),
          const SizedBox(height: 20),
          const Text('Translated Text:'),
          ValueListenableBuilder(
            valueListenable: _controller.translatedResultNotifier,
            builder: (context, translatedResult, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(translatedResult),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _languageSelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _languageButton(_controller.fromLanguage),
        IconButton(
          icon: Icon(Icons.swap_horiz),
          onPressed: () {
            setState(() {
              _controller.swapLanguages();
            });
          },
        ),
        _languageButton(_controller.toLanguage),
      ],
    );
  }

  Widget _languageButton(String language) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        language,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final imagePath = _controller.imageNotifier.value?.path;
    if (imagePath != null) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(imagePath) : Image.file(File(imagePath)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          onPressed: _controller.clear,
          backgroundColor: Colors.redAccent,
          tooltip: 'Delete',
          child: const Icon(Icons.delete),
        ),
        if (_controller.imageNotifier.value != null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              onPressed: _controller.cropImage,
              backgroundColor: Colors.blue,
              tooltip: 'Crop',
              child: const Icon(Icons.crop),
            ),
          )
      ],
    );
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Colors.blue.withOpacity(0.4),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Colors.blue,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Please upload an image',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  onPressed: _controller.uploadImage,
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.blue),
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
