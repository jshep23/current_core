import 'package:current_core/current_core.dart';

///Base class for any Current specific exception
abstract class CurrentException implements Exception {
  final StackTrace? stack;
  final Type type;

  CurrentException(this.stack, this.type);
}

abstract class CurrentPropertyException extends CurrentException {
  final String? propertyName;

  CurrentPropertyException(super.stack, this.propertyName, super.type);
}

///Thrown when an not-null-safe action is performed on a Nullable Current Property, and the underlying value
///was null.
///
///An example is performing an arithmetic operation on an [CurrentNullableIntProperty] when the int value
///was null
class CurrentPropertyNullValueException extends CurrentPropertyException {
  CurrentPropertyNullValueException(super.stack, super.propertyName, super.type);

  @override
  String toString() =>
      'CurrentPropertyNullValueException: The underlying value for ${propertyName ?? type} is null.\nStack: $stack';
}

/// Thrown when a [CurrentIntProperty] arithmetic function cannot convert its numeric result
/// into the explicitly requested generic type.
class CurrentIntPropertyInvalidArithmaticException extends CurrentPropertyException {
  final Type attemptedType;
  final Type resultType;

  CurrentIntPropertyInvalidArithmaticException(
    super.stack,
    super.propertyName,
    super.type, {
    required this.attemptedType,
    required this.resultType,
  });

  @override
  String toString() =>
      'CurrentIntPropertyInvalidArithmaticException: The arithmetic result for ${propertyName ?? type} was $resultType and could not be converted to $attemptedType. Use int, double, or num, or call the non-generic arithmetic helpers.\nStack: $stack';
}

///Thrown when an CurrentProperty value is changed and attempts to update the UI, but has not been added to the
///currentProps property of the associated CurrentViewModel
///
class PropertyNotAssignedToCurrentViewModelException extends CurrentPropertyException {
  PropertyNotAssignedToCurrentViewModelException(super.stack, super.propertyName, super.type);

  @override
  String toString() =>
      'PropertyNotAssignedToCurrentViewModelException: The value for ${propertyName ?? type} changed and failed to update the UI. Did you forget to add it to currentProps?.\nStack: $stack';
}

/// Thrown when a CurrentViewModel is assigned to a CurrentState, but that CurrentViewModel is already assigned to a different CurrentState.
///
/// This can occur when a CurrentWidget is rebuilt and attempts to assign the same CurrentViewModel instance to the new CurrentState. In Flutter this issue can be remedied by using the AutomaticKeepAliveClientMixin on the CurrentState's widget, which will preserve the CurrentState and its assigned CurrentViewModel across rebuilds.
class CurrentViewModelAlreadyAssignedException extends CurrentException {
  CurrentViewModelAlreadyAssignedException(super.stack, super.type);

  @override
  String toString() {
    final buffer = StringBuffer()
      ..writeln(
        'CurrentViewModelAlreadyAssignedException: The View Model of type $type has already been assigned to a different CurrentState.',
      )
      ..write(
        'This is generally due to the attached CurrentWidget being rebuilt. If you expect the parent widget to rebuild the CurrentWidget ',
      )
      ..writeln(
        'you can use the Flutter AutomaticKeepAliveClientMixin on the CurrentState $type is associated with.',
      )
      ..writeln('Stack Trace:\n$stack');

    return buffer.toString();
  }
}
