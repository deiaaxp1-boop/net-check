import 'package:flutter/material.dart';

void main() {
  runApp(const NetCheckApp());
}

class NetCheckApp extends StatelessWidget {
  const NetCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShbkaFahs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: Colors.cyan,
      ),
      home: const PinLoginScreen(),
    );
  }
}

class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({super.key});

  @override
  State<PinLoginScreen> createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  String enteredPin = '';
  final String correctPin = '1234';

  void _onNumberSelected(String number) {
    setState(() {
      if (enteredPin.length < 4) {
        enteredPin += number;
        if (enteredPin.length == 4) {
          if (enteredPin == correctPin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('الرمز غير صحيح، جرب 1234')),
            );
            enteredPin = '';
          }
        }
      }
    });
  }

  void _clearPin() {
    setState(() {
      if (enteredPin.isNotEmpty) {
        enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول - أداة الشبكة'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.lock_outline, size: 60, color: Colors.cyan),
          const SizedBox(height: 20),
          const Text('الرجاء إدخال رمز الحماية (PIN: 1234)', style: TextStyle(fontSize: 16)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index < enteredPin.length ? Colors.cyan : Colors.grey.shade700,
                ),
              );
            }),
          ),
          const SizedBox(height: 40),
          // أزرار الأرقام
          for (var row in [['1', '2', '3'], ['4', '5', '6'], ['7', '8', '9']])
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row.map((num) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => _onNumberSelected(num),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                    backgroundColor: Colors.grey.shade800,
                  ),
                  child: Text(num, style: const TextStyle(fontSize: 22, color: Colors.white)),
                ),
              )).toList(),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(width: 70, height: 70), // مكان فارغ لتنسيق اللوحة
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => _onNumberSelected('0'),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                    backgroundColor: Colors.grey.shade800,
                  ),
                  child: const Text('0', style: TextStyle(fontSize: 22, color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: _clearPin,
                  icon: const Icon(Icons.backspace, color: Colors.redAccent),
                  iconSize: 28,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text('دياب زيات - 00971551648787', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فحص الشبكة والاتصال'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi, size: 80, color: Colors.greenAccent),
            const SizedBox(height: 20),
            const Text('النظام جاهز ومتصل بنجاح', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم بدء فحص الشبكة بنجاح!')),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('بدء فحص الشبكة'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            ),
            const SizedBox(height: 20),
            const Text('دياب زيات - 00971551648787', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
