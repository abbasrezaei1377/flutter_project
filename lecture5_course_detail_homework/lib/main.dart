import 'package:flutter/material.dart';

void main() {
  runApp(const CourseApp());
}

class CourseApp extends StatelessWidget {
  const CourseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Course Detail',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const CourseDetailScreen(),
    );
  }
}

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Detail'),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // =========================
                  // HEADER CONTAINER
                  // =========================
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade700,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Advanced Mobile Programming',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          'Course Code: CS.SE.0731',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // =========================
                  // RICH TEXT
                  // =========================
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: 'Welcome to ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                            TextSpan(
                              text: 'Advanced Mobile Programming',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 18,
                              ),
                            ),

                            TextSpan(
                              text:
                                  '. This course focuses on building modern ',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),

                            TextSpan(
                              text: 'Flutter applications.',
                              style: TextStyle(
                                color: Colors.deepOrange,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Course Information',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =========================
                  // ROW
                  // Credit, Semester, Instructor
                  // =========================
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(
                        child: CourseInfoCard(
                          icon: Icons.credit_score,
                          title: 'Credit',
                          value: '3 Credits',
                        ),
                      ),

                      SizedBox(width: 8),

                      Expanded(
                        child: CourseInfoCard(
                          icon: Icons.calendar_month,
                          title: 'Semester',
                          value: 'Semester 7',
                        ),
                      ),

                      SizedBox(width: 8),

                      Expanded(
                        child: CourseInfoCard(
                          icon: Icons.person,
                          title: 'Instructor',
                          value: 'Course Teacher',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // =========================
                  // COURSE DESCRIPTION
                  // =========================
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.description,
                              color: Colors.blue,
                            ),

                            SizedBox(width: 8),

                            Text(
                              'Course Description',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 14),

                        Text(
                          'Advanced Mobile Programming is designed to help '
                          'students understand how modern mobile applications '
                          'are designed and developed using Flutter and Dart. '
                          'Throughout the course, students learn about common '
                          'widgets, layouts, forms, navigation, gestures, '
                          'responsive user interfaces, application state, '
                          'network communication and other important mobile '
                          'development concepts. The course also focuses on '
                          'creating applications that can work properly on '
                          'different screen sizes while following good user '
                          'interface and software development practices.',
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =========================
                  // CONTACT / DETAILS CARD
                  // Nested Row and Column
                  // =========================
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.blue.shade200,
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Instructor Contact & Details',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 18),

                        // Nested Row + Column
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              child: Icon(
                                Icons.person,
                                size: 40,
                              ),
                            ),

                            SizedBox(width: 18),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Course Instructor',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  SizedBox(height: 10),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.email,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'instructor@university.edu',
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        '+93 700 000 000',
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Computer Science Department',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =========================
                  // LEARNING OUTCOMES
                  // =========================
                  const Text(
                    'Learning Outcomes',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const OutcomeItem(
                    text: 'Understand Flutter common widgets.',
                  ),

                  const OutcomeItem(
                    text: 'Create responsive mobile layouts.',
                  ),

                  const OutcomeItem(
                    text: 'Use Row and Column effectively.',
                  ),

                  const OutcomeItem(
                    text:
                        'Build clean and organized mobile user interfaces.',
                  ),

                  const SizedBox(height: 25),

                  // Bottom message
                  Container(
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      'Keep learning and build great Flutter applications!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================
// COURSE INFORMATION WIDGET
// =============================================
class CourseInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const CourseInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 30,
          ),

          const SizedBox(height: 8),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            value,
            textAlign: TextAlign.center,
            softWrap: true,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================
// LEARNING OUTCOME ITEM
// =============================================
class OutcomeItem extends StatelessWidget {
  final String text;

  const OutcomeItem({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 22,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}