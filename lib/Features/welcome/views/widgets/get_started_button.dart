import 'package:flutter/material.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
    required this.isButtonActive,
    required this.nameController,
    required this.onTapGetStartedBtn,
  });
  final bool isButtonActive;
  final TextEditingController nameController;
  final VoidCallback onTapGetStartedBtn;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isButtonActive ? const Color(0xFF15B86C) : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: isButtonActive ? onTapGetStartedBtn : null,
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: Center(
              child: Text(
                'Let\'s Get Started',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
