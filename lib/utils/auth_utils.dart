import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:isa_app/models/user_1.dart';
// import 'package:isa_app/screens/sign_in_screen/sign_in_screen.dart';
import 'package:isa_app/utils/alert_utils.dart';
import 'package:roipil_authentication/screens/sign_in_screen.dart';
import 'package:roipil_authentication/services/roipil_auth_service.dart';

// TODO: May need to add another state called LOGGIN_IN or LOGGING_OUT (ie. in progress)
enum AUTH_STATUS { NOT_LOGGED_IN, LOGGED_IN_ANONYMOUS, LOGGED_IN_EMAIL }

class AuthUtils {
  static AUTH_STATUS getAuthStatus(User1 user) {
    if (user == null) {
      return AUTH_STATUS.NOT_LOGGED_IN;
    } else if (user.firebaseUser.isAnonymous) {
      return AUTH_STATUS.LOGGED_IN_ANONYMOUS;
    } else {
      return AUTH_STATUS.LOGGED_IN_EMAIL; // Assuming Name can never be empty.
    }
  }

  static String getDisplayUserName(User1 user) {
    AUTH_STATUS authStatus = getAuthStatus(user);
    switch (authStatus) {
      case AUTH_STATUS.NOT_LOGGED_IN:
        return 'Not signed in';
      case AUTH_STATUS.LOGGED_IN_ANONYMOUS:
        return 'Anonymous';
      case AUTH_STATUS.LOGGED_IN_EMAIL:
        return user.name; // Assuming Name can never be empty.
      default:
        return '-';
    }
  }

  static String getDisplayUserSubtitle(User1 user) {
    AUTH_STATUS authStatus = getAuthStatus(user);
    switch (authStatus) {
      case AUTH_STATUS.NOT_LOGGED_IN:
        return 'Click to sign in';
      case AUTH_STATUS.LOGGED_IN_ANONYMOUS:
        return '';
      case AUTH_STATUS.LOGGED_IN_EMAIL:
        return user.firebaseUser.email; // Assuming Name can never be empty.
      default:
        return '';
    }
  }

  static void _showSignInAlert(BuildContext context) {
    String title = 'Authentication';
    String message =
        'You can register, sign in, or sign in anonymously (limited access)';
    AlertUtils.showAlert(context, title, message, [
      TextButton(
        child: Text('Sign-in'),
        onPressed: () {
          // TODO: Make this more modular? As all three buttons call .pop()
          Navigator.pop(context);
          Navigator.pushNamed(context, SignInScreen.routeName, arguments: () {
            Navigator.pop(context);
          });
        },
      ),
      TextButton(
        child: Text('Sign-in anonymously'),
        onPressed: () => print('PRESSED'),
      ),
      TextButton(
        child: Text('Register'),
        onPressed: () => print('PRESSED'),
      ),
    ]);
    // TODO: Each button should take to the correct screen. Screens yet to be implemented.
  }

  static void _showSignOutAlert(BuildContext context, User1 user) {
    String title = 'Sign out?';
    String message =
        'Signed in as ${user.name}'; // TODO: Handle when user.name == null because anonymous

    AlertUtils.showAlert(context, title, message, [
      TextButton(
        onPressed: () async {
          await RoipilAuthService.logout();
          Navigator.pop(context);
        },
        child: Text('Yes'),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text('No'),
      ),
    ]);
  }

  static void showCorrectAuthenticationAlert(BuildContext context, User1 user) {
    if (user == null) {
      AuthUtils._showSignInAlert(context);
    } else {
      AuthUtils._showSignOutAlert(context, user);
    }
  }
}
