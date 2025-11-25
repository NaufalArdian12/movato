import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:movato/features/auth/presentation/progress/progress_page.dart';

import 'package:movato/features/course/course_page.dart';
import 'package:movato/features/profile/profile_page.dart';
import 'package:movato/src/core/widgets/course_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;
  int _selectedTab = 0;
  int _selectedDay = DateTime.now().weekday;

  final List<_ClassItem> _classes = [
    _ClassItem(
      title: 'Mengenal Dasar Pecahan',
      subtitle: 'Lorem ipsum dolor sit amet',
      progress: 0.76,
      image: 'assets/images/class4.jpg',
      color: const Color(0xFF7B61FF),
    ),
    _ClassItem(
      title: 'Pengenalan Bangun Ruang',
      subtitle: 'Lorem ipsum dolor sit amet',
      progress: 0.32,
      image: 'assets/images/class5.jpg',
      color: const Color(0xFF9F79FF),
    ),
    _ClassItem(
      title: 'Pengenalan Perkalian',
      subtitle: 'Lorem ipsum dolor sit amet',
      progress: 0.32,
      image: 'assets/images/class6.jpg',
      color: const Color(0xFF9F79FF),
    ),
  ];

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return const CoursePage();
      case 2:
        return const ProgressPage();
      case 3:
        return const ProfilePage();
      default:
        return _buildHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(child: _buildBody()),
      bottomNavigationBar: _bottomNav(),
    );
  }

  Widget _buildHomePage() {
    final today = DateFormat('EEEE, d MMMM', 'en_US').format(DateTime.now());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF7B61FF), Color(0xFF9F79FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _greeting(),
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'User Movato!!',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              _buildCalendar(today),
            ],
          ),
        ),

        const SizedBox(height: 16),
        _buildTabs(),

        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _classes.length,
            itemBuilder: (context, index) {
              final item = _classes[index];
              return _buildClassCard(item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCalendar(String today) {
    final days = ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                today,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(
                Icons.local_fire_department_rounded,
                color: Colors.orangeAccent,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (index) {
              final dayNum = index + 1;
              final isSelected = _selectedDay == dayNum;

              return GestureDetector(
                onTap: () => setState(() => _selectedDay = dayNum),
                child: Column(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.orangeAccent
                            : Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          days[index],
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildTabButton('Class', 0),
            _buildTabButton('Completed', 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    final active = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: active ? const Color(0xFF7B61FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                color: active ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClassCard(_ClassItem item) {
    return CourseCard(
      title: item.title,
      desc: item.subtitle,
      progress: item.progress,
      image: item.image,
      onLearnMore: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CoursePage()),
        );
      },
    );
  }

  Widget _bottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) => setState(() => _selectedIndex = index),
      selectedItemColor: const Color(0xFF7B61FF),
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          label: 'Courses',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart_outlined),
          label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}

class _ClassItem {
  final String title;
  final String subtitle;
  final double progress;
  final String image;
  final Color color;

  _ClassItem({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.image,
    required this.color,
  });
}
