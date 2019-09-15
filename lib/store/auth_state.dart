import 'package:meta/meta.dart';

import 'package:sbaclean/models/user.dart';

@immutable
class AuthState {

    // properties
    final bool isAuthenticated;
    final bool isAuthenticating;
    final bool isEditingPicture;
    final User user;
    final String error;
     final List<User> ranks; 
    // constructor with default
    AuthState({
        this.isAuthenticated = false,
        this.isAuthenticating = false,
        this.isEditingPicture = false,
        this.user,
        this.error,
        this.ranks = const []
    });

    // allows to modify AuthState parameters while cloning previous ones
    AuthState copyWith({
        bool isAuthenticated,
        bool isAuthenticating,
        bool isEditingPicture,
        String error,
        User user,
        List<User> ranks,
    }) {
        return new AuthState(
            isAuthenticated: isAuthenticated ?? this.isAuthenticated,
            isAuthenticating: isAuthenticating ?? this.isAuthenticating,
            isEditingPicture: isEditingPicture ?? this.isEditingPicture,
            error: error ?? this.error,
            user: user ?? this.user,
            ranks: ranks ?? this.ranks
        );
    }

  factory AuthState.fromJSON(Map<String, dynamic> json) => new AuthState(
        isAuthenticated: json['isAuthenticated'],
        isAuthenticating: json['isAuthenticating'],
        isEditingPicture: json['isEditingPicture'],
        error: json['error'],
        user: json['user'] == null ? null : new User.fromJson(json['user']),

    );

    Map<String, dynamic> toJSON() => <String, dynamic>{
        'isAuthenticated': this.isAuthenticated,
        'isAuthenticating': this.isAuthenticating,
         'isEditingPicture': this.isEditingPicture,
        'error': this.error,
    };

    @override
    String toString() {
        return '''{
                isAuthenticated: $isAuthenticated,
                isAuthenticating: $isAuthenticating,
                user: $user,
                error: $error
            }''';
    }
}