class AppAuthState {
  final bool loading;

  AppAuthState({this.loading = false});

  AppAuthState copyWith({bool? loading}) {
    return AppAuthState(loading: loading ?? this.loading);
  }
}
