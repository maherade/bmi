abstract class AppState {}

class AppInitial extends AppState {}

class ChangeBottomNavBarState extends AppState {}

class ChangeAgeStateSuccess extends AppState {}

class ChangeWeightStateSuccess extends AppState {}

class CalculateBMIStateSuccess extends AppState {}

class ChangeHeightStateSuccess extends AppState {}

class ChangeGenderStateSuccess extends AppState {}

class ChangeResultStringStateSuccess extends AppState {}

//SignUp States

class SignUpLoadingState extends AppState {}

class SignUpSuccessState extends AppState {}

class SignUpErrorState extends AppState {SignUpErrorState(String error);}

class SaveUserLoadingState extends AppState {}

class SaveUserSuccessState extends AppState {}

class SaveUserErrorState  extends AppState {}

//Login States

class LoginLoadingState extends AppState {}

class LoginSuccessState extends AppState {}

class LoginErrorState extends AppState {LoginErrorState(String error);}

class GetUserLoadingState extends AppState {}

class GetUserSuccessState extends AppState {}

class GetUserErrorState extends AppState {}

class AddAnalysisLoadingState extends AppState {}

class AddAnalysisSuccessState extends AppState {}

class AddAnalysisErrorState extends AppState {}

class GetAnalysisLoadingState extends AppState {}

class GetAnalysisSuccessState extends AppState {}

class GetAnalysisErrorState extends AppState {}


class DeleteAnalysisSuccessState extends AppState {}


