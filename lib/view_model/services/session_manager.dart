class SessionController{
  static final SessionController _session = SessionController._();
  String? userId;

  factory SessionController(){
    return _session;
  }
  SessionController._();
  // static SessionController get instance  => _session ;
}