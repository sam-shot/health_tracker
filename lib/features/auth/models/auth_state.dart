class AppAuthState {
  final bool loading;
  final bool googleLoading;

  AppAuthState({this.loading = false, this.googleLoading = false});

  AppAuthState copyWith({
    bool? loading,
    bool? googleLoading,
  }) {
    return AppAuthState(
      loading: loading ?? this.loading,
      googleLoading: googleLoading ?? this.googleLoading,
    );
  }
}
