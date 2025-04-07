import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:rate_my_landlord/screens/cubit/bottom_nav_bar_cubit.dart';
import 'package:test/test.dart';

void main(){
  group('bottomNavBarCubit',(){
    test('Initial state Home',(){
      final navBarCubit = BottomNavBarCubit(BottomNavBarCubit.home);
      expect(navBarCubit.state,BottomNavBarCubit.home);
    });

    test('Initial state info',(){
      final navBarCubit = BottomNavBarCubit(BottomNavBarCubit.info);
      expect(navBarCubit.state,BottomNavBarCubit.info);
    });

    test('Initial state profile',(){
      final navBarCubit = BottomNavBarCubit(BottomNavBarCubit.profile);
      expect(navBarCubit.state,BottomNavBarCubit.profile);
    });

    test('Initial state search',(){
      final navBarCubit = BottomNavBarCubit(BottomNavBarCubit.search);
      expect(navBarCubit.state,BottomNavBarCubit.search);
    });

      group('Select item on the nave bar home/info/profile/search',(){
        blocTest<BottomNavBarCubit, int >('emits info when info icon is pressed',
            build: ()=> BottomNavBarCubit(BottomNavBarCubit.home),
            act: (cubit) => cubit.setBottomNavBarIndex(BottomNavBarCubit.info) ,
            expect: () => <int> [
              BottomNavBarCubit.info,
            ]);
      });

      blocTest<BottomNavBarCubit, int >('emits profile when profile icon is pressed',
          build: ()=> BottomNavBarCubit(BottomNavBarCubit.home),
          act: (cubit) => cubit.setBottomNavBarIndex(BottomNavBarCubit.profile) ,
          expect: () => <int> [
            BottomNavBarCubit.profile,
          ]);

      blocTest<BottomNavBarCubit, int >('emits search when profile icon is search',
          build: ()=> BottomNavBarCubit(BottomNavBarCubit.home),
          act: (cubit) => cubit.setBottomNavBarIndex(BottomNavBarCubit.search) ,
          expect: () => <int> [
             BottomNavBarCubit.search,
          ]);

      blocTest<BottomNavBarCubit, int >('emits same page on multiple presses',
        build: ()=> BottomNavBarCubit(BottomNavBarCubit.home),
        act: (cubit) => cubit..setBottomNavBarIndex(BottomNavBarCubit.home)
                              ..setBottomNavBarIndex(BottomNavBarCubit.home),
        expect: () => <int> [
          BottomNavBarCubit.home,
        ]);

      blocTest<BottomNavBarCubit, int >('emits different states on multiple presses',
        build: ()=> BottomNavBarCubit(BottomNavBarCubit.home),
        act: (cubit) => cubit..setBottomNavBarIndex(BottomNavBarCubit.home)
                              ..setBottomNavBarIndex(BottomNavBarCubit.info)
                              ..setBottomNavBarIndex(BottomNavBarCubit.search)
                              ..setBottomNavBarIndex(BottomNavBarCubit.profile),
        expect: () => <int> [
          BottomNavBarCubit.home,
          BottomNavBarCubit.info,
          BottomNavBarCubit.search,
          BottomNavBarCubit.profile,
        ]);
  });

}
