import 'package:flutter/material.dart';

class ExamFormPage extends StatefulWidget {
  const ExamFormPage({super.key});

  @override
  _ExamFormPageState createState() => _ExamFormPageState();
}

class _ExamFormPageState extends State<ExamFormPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  String selectedExamType = 'UTS';
  bool isChecked = false;

  List<Question> questions = [
    Question(
      questionText: "Apa ibukota Indonesia?",
      options: ["Jakarta", "Bali", "Surabaya", "Medan"],
      selectedOption: '',
    ),
    Question(
      questionText: "Siapa presiden pertama Indonesia?",
      options: ["Soekarno", "Soeharto", "BJ Habibie", "Jokowi"],
      selectedOption: '',
    ),
  ];

  void showSummary() {
    if (nameController.text.isEmpty || subjectController.text.isEmpty || !isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua data harus diisi!')),
      );
      return;
    }

    String questionSummary = questions
        .map((q) => '${q.questionText} - Jawaban: ${q.selectedOption}')
        .join('\n');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ringkasan Data'),
          content: Text(
            'Nama: ${nameController.text}\n'
                'Mata Pelajaran: ${subjectController.text}\n'
                'Jenis Ujian: $selectedExamType\n'
                'Persetujuan: ${isChecked ? "Setuju" : "Tidak Setuju"}\n\n'
                'Jawaban Ujian:\n$questionSummary',
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Tutup'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Form Ujian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: subjectController,
              decoration: const InputDecoration(labelText: 'Mata Pelajaran'),
            ),
            DropdownButton<String>(
              value: selectedExamType,
              isExpanded: true,
              onChanged: (newValue) {
                setState(() {
                  selectedExamType = newValue!;
                });
              },
              items: ['UTS', 'UAS', 'Quiz'].map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Text('Saya siap mengikuti ujian'),
              ],
            ),
            ...questions.map((q) => QuestionWidget(question: q)),
            ElevatedButton(
              onPressed: showSummary,
              child: const Text('Tampilkan Ringkasan'),
            ),
          ],
        ),
      ),
    );
  }
}

class Question {
  String questionText;
  List<String> options;
  String selectedOption;

  Question({
    required this.questionText,
    required this.options,
    required this.selectedOption,
  });
}

class QuestionWidget extends StatelessWidget {
  final Question question;

  const QuestionWidget({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(question.questionText),
        ...question.options.map((option) => RadioListTile<String>(
          title: Text(option),
          value: option,
          groupValue: question.selectedOption,
          onChanged: (value) {
            question.selectedOption = value!;
            (context as Element).markNeedsBuild();
          },
        )),
      ],
    );
  }
}