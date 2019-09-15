import 'package:redux/redux.dart';

import 'package:sbaclean/actions/auth_actions.dart';
import 'package:sbaclean/models/user.dart';
import 'package:sbaclean/store/auth_state.dart';

Reducer<AuthState> authReducer = combineReducers([
    new TypedReducer<AuthState, UserLoginRequest>(userLoginRequestReducer),
    new TypedReducer<AuthState, UserLoginSuccess>(userLoginSuccessReducer),
    new TypedReducer<AuthState, UserLoginFailure>(userLoginFailureReducer),
    new TypedReducer<AuthState, UserLogout>(userLogoutReducer),
    new TypedReducer<AuthState, GetUserRankingAction>(getUserRanking), 
    new TypedReducer<AuthState, GetUserByEmailAction>(getUserByEmail), 
    new TypedReducer<AuthState, GetUserPositionAction>(getUserPosition),
    new TypedReducer<AuthState, EditProfilePicRequest>(updateProfilePicRequest),
    new TypedReducer<AuthState, UserProfilePicture>(updateUserProfilePicture),
    new TypedReducer<AuthState, UserUpdate>(userUpdateReducer)


]);

AuthState getUserPosition(AuthState authState, GetUserPositionAction action){
    User user = authState.user;
    user.position = action.position;
    return authState.copyWith(
      user: user
    );
}

AuthState getUserByEmail(AuthState authState, GetUserByEmailAction action){
    return authState.copyWith(
      user: action.user
    );
}
  


AuthState userLoginRequestReducer(AuthState auth, UserLoginRequest action) {
    return auth.copyWith(
        isAuthenticated: false,
        isAuthenticating: true,

    );
}

AuthState userLoginSuccessReducer(AuthState auth, UserLoginSuccess action) {
    return auth.copyWith(
        isAuthenticated: true,
        isAuthenticating: false,
        user: action.user
    );
}

AuthState userLoginFailureReducer(AuthState auth, UserLoginFailure action) {
    return auth.copyWith(
        isAuthenticated: false,
        isAuthenticating: false,
        error: action.error
    );
}

AuthState userLogoutReducer(AuthState auth, UserLogout action) {
    return new AuthState();
}

AuthState getUserRanking(AuthState state, GetUserRankingAction action) {
    return state.copyWith(ranks: action.ranks);
}

AuthState userUpdateReducer(AuthState auth, UserUpdate action) {
    return auth.copyWith(
        user: action.user
    );
}

AuthState updateUserProfilePicture(AuthState state, UserProfilePicture action) {
    User user = state.user;
    user.profile_picture = action.profile_picture;
    return state.copyWith(
        isEditingPicture: false,
        user: user

    );
}
AuthState updateProfilePicRequest(AuthState authState, EditProfilePicRequest action){
    return authState.copyWith(
        isEditingPicture: true,
    );
}