import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const Spacer(flex: 2),
          Image.asset('assets/images/welcome_image.png'),
          const Spacer(flex: 3),
          Text(
            textAlign: TextAlign.center,
            'Welcome to our Pivot Chat \nmessage app',
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
              textAlign: TextAlign.center,
              'Freedom talk  \n enjoy every moment',
              style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.color
                      ?.withOpacity(0.64))),
          const Spacer(flex: 3),
          FittedBox(
            child: TextButton(
                onPressed: () => context.go("/loging"),
                child: Row(
                  children: [
                    Text(
                      'Skip',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.color
                              ?.withOpacity(0.64)),
                    ),
                    const SizedBox(width: 20.0 / 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.8),
                    )
                  ],
                )),
          )
        ],
      )),
    );
  }
}
