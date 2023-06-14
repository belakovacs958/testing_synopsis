import 'package:clean_architecture/core/error/failures/invalid_input_failure.dart';
import 'package:clean_architecture/core/utilities/input_converter.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    final testCases = {
      '123': const Right(123),
      'abc': Left(InvalidInputFailure()),
      '-123': Left(InvalidInputFailure()),
      '': Left(InvalidInputFailure()),
      '-21474836': Left(InvalidInputFailure()), // Assuming 32-bit integers
      '1234567': Right(1234567), // Assuming 32-bit integers
    };

    testCases.forEach((input, expectedOutput) {
      test('input: $input, expectedOutput: $expectedOutput', () {
        final result = inputConverter.stringToUnsignedInteger(input);
        expect(result, equals(expectedOutput));
      });
    });
  });
}

