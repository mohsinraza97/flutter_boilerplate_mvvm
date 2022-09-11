enum ResponseType {
  success(200),
  unauthorized(401),
  timeout(-1),
  internetFailure(-2),
  unknown(-3);

  const ResponseType(this.value);

  final num value;

  int get asInt => value.toInt();
}
