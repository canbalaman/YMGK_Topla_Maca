import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<TextEditingController> _controllers =
      List.generate(10, (_) => TextEditingController());

  bool validateInputs(List<int> values) {
    final expectedValues = [2, 1, 1, 9, 7, 4, 1, 8, 9, 2];

    if (values.length != expectedValues.length) {
      return false;
    }

    for (var i = 0; i < values.length; i++) {
      if (values[i] != expectedValues[i]) {
        return false;
      }
    }

    for (var i = 0; i < expectedValues.length; i++) {
      if (!values.contains(expectedValues[i])) {
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 100),
                  buildInputField(0),
                  const SizedBox(width: 50),
                  buildInputField(1),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 100),
                  buildInputField(2),
                  const SizedBox(width: 0),
                  buildInputField(3),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildInputField(4),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 200),
                  buildInputField(5),
                  const SizedBox(width: 50),
                  buildInputField(6),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 170),
                  buildInputField(7),
                  buildInputField(8),
                  buildInputField(9),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () {
                final values = _controllers
                    .map((controller) => int.parse(controller.text))
                    .toList();
                final isValid = validateInputs(values);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(isValid ? 'Tebrikler!' : 'Hata'),
                      content: Text(isValid
                          ? 'Değerler doğru!'
                          : 'Değerler yanlış! Lütfen kontrol ediniz.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Tamam'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Gönder'),
            );
          },
        ),
      ),
    );
  }

  Widget buildInputField(int index) {
    return Container(
      width: 65,
      height: 73,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        controller: _controllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 40),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
