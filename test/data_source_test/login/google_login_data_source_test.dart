import 'package:flutter_test/flutter_test.dart';
import 'package:healthy_bag/data/data_source/auth_data_source/remote/google_auth_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockUserCredential extends Mock implements UserCredential {}

class MockAuthCredential extends Mock implements AuthCredential {}

void main() {
  late GoogleAuthDataSource dataSource;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    mockGoogleSignIn = MockGoogleSignIn();
    mockFirebaseAuth = MockFirebaseAuth();

    // Data Source에서는 굳이라는 느낌이 강함
    dataSource = GoogleAuthDataSource(
      googleSignIn: mockGoogleSignIn,
      firebaseAuth: mockFirebaseAuth,
    );

    registerFallbackValue(MockAuthCredential());
  });

  group('GoogleAuthDataSource', () {
    test('signIn returns UserCredential on successful login', () async {
      final mockGoogleUser = MockGoogleSignInAccount();
      final mockGoogleAuth = MockGoogleSignInAuthentication();
      final mockUserCredential = MockUserCredential();

      when(
        () => mockGoogleSignIn.signIn(),
      ).thenAnswer((_) async => mockGoogleUser);
      when(
        () => mockGoogleUser.authentication,
      ).thenAnswer((_) async => mockGoogleAuth);
      when(() => mockGoogleAuth.accessToken).thenReturn('test_access_token');
      when(() => mockGoogleAuth.idToken).thenReturn('test_id_token');

      when(
        () => mockFirebaseAuth.signInWithCredential(any()),
      ).thenAnswer((_) async => mockUserCredential);

      final result = await dataSource.getUserCredential();

      expect(result, isA<UserCredential>());
      verify(() => mockGoogleSignIn.signIn()).called(1);
      verify(() => mockFirebaseAuth.signInWithCredential(any())).called(1);
    });

    test('signIn returns null when Google Sign In is cancelled', () async {
      when(() => mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

      final result = await dataSource.getUserCredential();

      expect(result, isNull);
      verify(() => mockGoogleSignIn.signIn()).called(1);
      verifyNever(() => mockFirebaseAuth.signInWithCredential(any()));
    });

    test('signIn throws exception when Google Sign In fails', () async {
      when(
        () => mockGoogleSignIn.signIn(),
      ).thenThrow(Exception('Sign in failed'));

      expect(() => dataSource.getUserCredential(), throwsException);
      verify(() => mockGoogleSignIn.signIn()).called(1);
      verifyNever(() => mockFirebaseAuth.signInWithCredential(any()));
    });
  });
}
