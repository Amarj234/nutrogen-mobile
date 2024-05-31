import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nutrogen/data/model/meal_list_model.dart';
import 'package:nutrogen/data/model/meal_plan_model.dart';
import 'package:nutrogen/data/model/package_list_model.dart';
import 'package:nutrogen/res/app_constants.dart';
import 'package:nutrogen/ui/common/page_not_found_widget.dart';
import 'package:nutrogen/ui/module/addMeal/add_meal_page.dart';
import 'package:nutrogen/ui/module/aiGenerateMealPlan/ai_generate_meal_plan.dart';
import 'package:nutrogen/ui/module/challenges/challenge_details_page.dart';
import 'package:nutrogen/ui/module/challenges/levels_page.dart';
import 'package:nutrogen/ui/module/challenges/task_completed_page.dart';
import 'package:nutrogen/ui/module/challenges/tasks_page.dart';
import 'package:nutrogen/ui/module/dashboard/dashboard_page.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/generate_ai_main.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/generated_ai_five.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/generated_ai_four.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/generated_ai_one.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/generated_ai_plan_three.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/generated_ai_six.dart';
import 'package:nutrogen/ui/module/genratedAiPlan/genrated_ai_plan_page.dart';
import 'package:nutrogen/ui/module/groceryList/grocery_list.dart';
import 'package:nutrogen/ui/module/groceryList/grocery_list_details.dart';
import 'package:nutrogen/ui/module/groceryList/swap_food.dart';
import 'package:nutrogen/ui/module/home/home_page.dart';
import 'package:nutrogen/ui/module/logFood/log_food_page.dart';
import 'package:nutrogen/ui/module/login/login_page.dart';
import 'package:nutrogen/ui/module/mealPlanDetailsOverview/meal_plan_details_overview_page.dart';
import 'package:nutrogen/ui/module/mealPlans/dietician_approve_meal_paln.dart';
import 'package:nutrogen/ui/module/mealPlans/meal_plan_log.dart';
import 'package:nutrogen/ui/module/mealPlans/meal_plans_page.dart';
import 'package:nutrogen/ui/module/messageNotification/chat/chat_page.dart';
import 'package:nutrogen/ui/module/messageNotification/chat/full_screen_media_page.dart';
import 'package:nutrogen/ui/module/messageNotification/chat/media_list_page.dart';
import 'package:nutrogen/ui/module/messageNotification/message/message_page.dart';
import 'package:nutrogen/ui/module/more/more_page.dart';
import 'package:nutrogen/ui/module/newsFeed/create_news_feed.dart';
import 'package:nutrogen/ui/module/newsFeed/news_feed_details.dart';
import 'package:nutrogen/ui/module/newsFeed/news_feed_page.dart';
import 'package:nutrogen/ui/module/notification/notification_page.dart';
import 'package:nutrogen/ui/module/nutritionSummary/meal_history_page.dart';
import 'package:nutrogen/ui/module/nutritionSummary/nutrition_summary_page.dart';
import 'package:nutrogen/ui/module/onbording/onbording_page.dart';
import 'package:nutrogen/ui/module/paywall/paywall_first_page.dart';
import 'package:nutrogen/ui/module/paywall/paywall_second_page.dart';
import 'package:nutrogen/ui/module/recipe/favourites/favourites_recipe.dart';
import 'package:nutrogen/ui/module/recipe/my_recipe.dart';
import 'package:nutrogen/ui/module/recipe/recipe_details_page.dart';
import 'package:nutrogen/ui/module/recipe/recipe_main_page.dart';
import 'package:nutrogen/ui/module/scanBarcode/scan_barcode_page.dart';
import 'package:nutrogen/ui/module/search/search_page.dart';
import 'package:nutrogen/ui/module/settings/friends_daily_task.dart';
import 'package:nutrogen/ui/module/settings/integrated_mobile_apps.dart';
import 'package:nutrogen/ui/module/settings/invite_friends_page.dart';
import 'package:nutrogen/ui/module/settings/invite_from_friends.dart';
import 'package:nutrogen/ui/module/settings/mobile_app_details.dart';
import 'package:nutrogen/ui/module/settings/mobile_app_link.dart';
import 'package:nutrogen/ui/module/settings/payment_plan_page.dart';
import 'package:nutrogen/ui/module/settings/profile/profile_settings_page.dart';
import 'package:nutrogen/ui/module/settings/push_notification_page.dart';
import 'package:nutrogen/ui/module/settings/settings_page.dart';
import 'package:nutrogen/ui/module/shopping/cart/cart_page.dart';
import 'package:nutrogen/ui/module/shopping/productDetails/product_details_page.dart';
import 'package:nutrogen/ui/module/shopping/shop/shop_page.dart';
import 'package:nutrogen/ui/module/signup/signup_page.dart';
import 'package:nutrogen/utils/route_observer.dart';

CustomTransitionPage customTransitionPage({
  required LocalKey localKey,
  required Widget pagelink,
  required Offset offset,
}) =>
    CustomTransitionPage(
      key: localKey,
      child: pagelink,
      barrierDismissible: true,
      opaque: false,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
        position: animation.drive(
          Tween(
            begin: offset,
            end: Offset.zero,
          ).chain(
            CurveTween(curve: Curves.ease),
          ),
        ),
        child: child,
      ),
    );

CustomTransitionPage fadeTransitionPage({
  required LocalKey localKey,
  required Widget pagelink,
}) =>
    CustomTransitionPage(
      key: localKey,
      child: pagelink,
      fullscreenDialog: true,
      opaque: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1.0,
        ).animate(animation),
        child: child,
      ),
    );

class AppRouters {
  static final rootKey = GlobalKey<NavigatorState>();
  static final _bottomNavShellKey = GlobalKey<NavigatorState>();

  /* -------------------------------------------------------------------------- */
  /*                                  PAGE PATH                                 */
  /* -------------------------------------------------------------------------- */
  static const String login = 'login';
  static const String signup = 'signup';
  static const String paywallFirst = 'paywall_first';
  static const String paywallSecond = 'paywall_second';
  static const String onbording = 'onbording';
  static const String dashboard = 'dashboard';
  static const String logFood = 'log_food';
  static const String newsFeed = 'news_feed';
  static const String mealPlans = 'meal_plans';
  static const String more = 'more';
  static const String addMeal = 'add_meal';
  static const String scanBarcode = 'scan_barcode';
  static const String nutritionSummary = 'nutrition_summary';
  static const String mealHistory = 'meal_history';
  static const String mealPlanLog = 'meal_plan_log';
  static const String mealPlanDetails = 'meal_plan_details_overview_page';
  static const String dieticiAnapproveMealPaln = 'dietician_approve_meal_paln';
  static const String genratedAiPlanPage = 'genrated_ai_plan_page';
  static const String genratedAiPlanThree = 'generated_ai_plan_three';
  static const String genratedAiOne = 'genrated_ai_one';
  static const String genratedAiPlanFour = 'generated_ai_four';
  static const String genratedAiPlanFive = 'generated_ai_five';
  static const String genratedAiPlanSix = 'generated_ai_six';
  static const String aiGenerateMealPlan = 'ai_generate_meal_plan';
  static const String groceryList = 'grocery_list';
  static const String groceryListDetails = 'grocery_list_details';
  static const String swapFood = 'swap_food';
  static const String generateAiMain = 'generate_ai_main';
  static const String myRecipe = 'my_recipe';
  static const String recipeMain = 'recipe_main';
  static const String favouritesRecipe = 'favourites_recipe';
  static const String recipeDetails = 'recipe_details';
  static const String levels = 'levels';
  static const String tasks = 'tasks';
  static const String challengeDetails = 'challenge_details';
  static const String taskCompletedPage = 'task_completed_page';
  static const String shop = 'shop';
  static const String productDetails = 'product_details';
  static const String cart = 'cart';
  static const String settingsPage = 'settings_page';
  static const String inviteFriendsPage = 'invite_friends_page';
  static const String inviteFromFriends = 'invite_from_friends';
  static const String mobileAppLink = 'mobile_app_link';
  static const String integratedMobileApps = 'integrated_mobile_apps';
  static const String mobileAppDetails = 'mobile_app_details';
  static const String paymentPlanPage = 'payment_plan_page';
  static const String friendsDailyTask = 'friends_daily_task';
  static const String pushNotificationPage = 'push_notification_page';
  static const String profileSettingsPage = 'profile_settings_page';
  static const String message = 'message';
  static const String chat = 'chat';
  static const String newsFeedDetails = 'news_feed_details';
  static const String createNewsFeed = 'create_news_feed';
  static const String notification = 'notification';
  static const String search = 'search';
  static const String mediaList = 'media_list';
  static const String fullScreenMedia = 'full_screen_media';

  /* -------------------------------------------------------------------------- */
  /*                               CONFIGURATIONS                               */
  /* -------------------------------------------------------------------------- */

  final GoRouter router = GoRouter(
    navigatorKey: rootKey,
    observers: [GoRouteObserver()],
    initialLocation:
        Hive.box(AppConstants.appName).get(AppConstants.tokenKey) != null
            ? '/$dashboard'
            : '/$login',
    debugLogDiagnostics: AppConstants.isDebugMode,
    errorBuilder: (context, state) => const PageNotFoundPage(),
    routes: [
      GoRoute(
        name: mealHistory,
        path: '/$mealHistory',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const MealHistory(),
      ),
      GoRoute(
        name: newsFeedDetails,
        path: '/$newsFeedDetails',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const NewsFeedDetails(),
      ),
      GoRoute(
        name: createNewsFeed,
        path: '/$createNewsFeed',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const CreateNewsFeed(),
      ),
      // GoRoute(
      //   name: profileSettingsPage,
      //   path: '/$profileSettingsPage',
      //   parentNavigatorKey: rootKey,
      //   builder: (context, state) => const ProfileSettingsPage(),
      // ),
      GoRoute(
        name: pushNotificationPage,
        path: '/$pushNotificationPage',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const PushNotificationPage(),
      ),
      GoRoute(
        name: friendsDailyTask,
        path: '/$friendsDailyTask',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const FriendsDailyTask(),
      ),
      GoRoute(
        name: paymentPlanPage,
        path: '/$paymentPlanPage',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const PaymentPlanPage(),
      ),
      GoRoute(
        name: mobileAppDetails,
        path: '/$mobileAppDetails',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const MobileAppDetails(),
      ),
      GoRoute(
        name: integratedMobileApps,
        path: '/$integratedMobileApps',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const IntegratedMobileApps(),
      ),
      GoRoute(
        name: mobileAppLink,
        path: '/$mobileAppLink',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const MobileAppLink(),
      ),
      GoRoute(
        name: inviteFromFriends,
        path: '/$inviteFromFriends',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const InviteFromFriends(),
      ),

      GoRoute(
        name: settingsPage,
        path: '/$settingsPage',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        name: taskCompletedPage,
        path: '/$taskCompletedPage',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const TaskCompletedPage(),
      ),
      GoRoute(
        name: mealPlanDetails,
        path: '/$mealPlanDetails',
        parentNavigatorKey: rootKey,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: MealPlanDetailsPage(
            approveMealListREntity: state.extra as MealPlanR?,
          ),
          barrierDismissible: true,
          opaque: false,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: animation.drive(
              Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).chain(
                CurveTween(curve: Curves.ease),
              ),
            ),
            child: child,
          ),
        ),
      ),
      GoRoute(
        name: recipeMain,
        path: '/$recipeMain',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const RecipeMainPage(),
      ),
      GoRoute(
        name: tasks,
        path: '/$tasks',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const TasksPage(),
      ),
      GoRoute(
        name: challengeDetails,
        path: '/$challengeDetails',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const ChallengeDetailsPage(),
      ),
      GoRoute(
        name: levels,
        path: '/$levels',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const LevelsPage(),
      ),
      GoRoute(
        name: recipeDetails,
        path: '/$recipeDetails',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const RecipeDetailsPage(),
      ),
      GoRoute(
        name: myRecipe,
        path: '/$myRecipe',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const MyRecipe(),
      ),
      GoRoute(
        name: favouritesRecipe,
        path: '/$favouritesRecipe',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const FavouritesRecipe(),
      ),
      GoRoute(
        name: generateAiMain,
        path: '/$generateAiMain',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const GenerateAiMain(),
      ),
      GoRoute(
        name: swapFood,
        path: '/$swapFood',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const SwapFood(),
      ),
      GoRoute(
        name: groceryListDetails,
        path: '/$groceryListDetails',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const GroceryListDetails(),
      ),
      GoRoute(
        name: groceryList,
        path: '/$groceryList',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const GroceryList(),
      ),
      GoRoute(
        name: aiGenerateMealPlan,
        path: '/$aiGenerateMealPlan',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const AiGenratedMealPlan(),
      ),
      GoRoute(
        name: genratedAiPlanSix,
        path: '/$genratedAiPlanSix',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const GenratedAiPlanSix(),
      ),
      GoRoute(
        name: genratedAiPlanFive,
        path: '/$genratedAiPlanFive',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const GenratedAiFive(),
      ),
      GoRoute(
        name: genratedAiPlanFour,
        path: '/$genratedAiPlanFour',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const GenratedAiPlanFour(),
      ),
      GoRoute(
        name: genratedAiOne,
        path: '/$genratedAiOne',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const GenratedAiOne(),
      ),
      GoRoute(
        name: genratedAiPlanPage,
        path: '/$genratedAiPlanPage',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const GenratedAiPlanPage(),
      ),
      GoRoute(
        name: genratedAiPlanThree,
        path: '/$genratedAiPlanThree',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const GenratedAiPlanThree(),
      ),
      GoRoute(
        name: mealPlanLog,
        path: '/$mealPlanLog',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const MealPlanLog(),
      ),
      GoRoute(
        name: login,
        path: '/$login',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: signup,
        path: '/$signup',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        name: paywallFirst,
        path: '/$paywallFirst',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const PaywallFirstPage(),
      ),
      GoRoute(
        name: paywallSecond,
        path: '/$paywallSecond',
        parentNavigatorKey: rootKey,
        builder: (context, state) => PaywallSecondPage(
          package: state.extra as PackageR?,
        ),
      ),
      GoRoute(
        name: onbording,
        path: '/$onbording',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const OnbordingPage(),
      ),
      GoRoute(
        name: shop,
        path: '/$shop',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const ShopPage(),
      ),
      GoRoute(
        name: productDetails,
        path: '/$productDetails',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const ProductDetailsPage(),
      ),
      GoRoute(
        name: cart,
        path: '/$cart',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const CartPage(),
      ),
      GoRoute(
        name: message,
        path: '/$message',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const MessagePage(),
      ),
      GoRoute(
        name: chat,
        path: '/$chat',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const ChatPage(),
      ),
      GoRoute(
        name: notification,
        path: '/$notification',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        name: search,
        path: '/$search',
        parentNavigatorKey: rootKey,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        name: mediaList,
        path: '/$mediaList',
        parentNavigatorKey: rootKey,
        builder: (context, state) => MediaListPage(
          media: state.extra as List<String>,
        ),
      ),
      GoRoute(
        name: fullScreenMedia,
        path: '/$fullScreenMedia',
        parentNavigatorKey: rootKey,
        pageBuilder: (context, state) => fadeTransitionPage(
          localKey: state.pageKey,
          pagelink: FullScreenMediaPage(
            media: state.extra as List<String>,
            index: state.uri.queryParameters['index'],
          ),
        ),
      ),
      ShellRoute(
        parentNavigatorKey: rootKey,
        navigatorKey: _bottomNavShellKey,
        builder: (context, state, child) => HomePage(child: child),
        routes: [
          GoRoute(
            name: dashboard,
            path: '/$dashboard',
            parentNavigatorKey: _bottomNavShellKey,
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            name: logFood,
            path: '/$logFood',
            parentNavigatorKey: _bottomNavShellKey,
            builder: (context, state) => const LogFoodPage(),
          ),
          GoRoute(
            name: newsFeed,
            path: '/$newsFeed',
            parentNavigatorKey: _bottomNavShellKey,
            builder: (context, state) => const NewsFeedPage(),
          ),
          GoRoute(
            name: mealPlans,
            path: '/$mealPlans',
            parentNavigatorKey: _bottomNavShellKey,
            builder: (context, state) => const MealPlansPage(),
          ),
          GoRoute(
            name: more,
            path: '/$more',
            parentNavigatorKey: _bottomNavShellKey,
            builder: (context, state) => const MorePage(),
          ),
        ],
      ),

      GoRoute(
        name: addMeal,
        path: '/$addMeal',
        parentNavigatorKey: rootKey,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: AddMealPage(
            mealType: state.uri.queryParameters['mealType'],
            mealDate: state.uri.queryParameters['mealDate'],
          ),
          barrierDismissible: true,
          opaque: false,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: animation.drive(
              Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).chain(
                CurveTween(curve: Curves.ease),
              ),
            ),
            child: child,
          ),
        ),
      ),

      GoRoute(
        name: dieticiAnapproveMealPaln,
        path: '/$dieticiAnapproveMealPaln',
        parentNavigatorKey: rootKey,
        pageBuilder: (context, state) => customTransitionPage(
          localKey: state.pageKey,
          pagelink: const DieticianApproveMealPlan(),
          offset: const Offset(0, 1),
        ),
      ),

      GoRoute(
        name: profileSettingsPage,
        path: '/$profileSettingsPage',
        parentNavigatorKey: rootKey,
        pageBuilder: (context, state) => customTransitionPage(
          localKey: state.pageKey,
          pagelink: const ProfileSettingsPage(),
          offset: const Offset(1.0, 0.5),
        ),
      ),

      GoRoute(
        name: inviteFriendsPage,
        path: '/$inviteFriendsPage',
        parentNavigatorKey: rootKey,
        pageBuilder: (context, state) => customTransitionPage(
          localKey: state.pageKey,
          pagelink: const InviteFriendsPage(),
          offset: const Offset(1.0, 0.0),
        ),
      ),

      GoRoute(
        name: scanBarcode,
        path: '/$scanBarcode',
        parentNavigatorKey: rootKey,
        pageBuilder: (context, state) => customTransitionPage(
          localKey: state.pageKey,
          pagelink: const ScanBarcodePage(),
          offset: const Offset(0, 1),
        ),
      ),

      GoRoute(
        name: nutritionSummary,
        path: '/$nutritionSummary',
        parentNavigatorKey: rootKey,
        pageBuilder: (context, state) => customTransitionPage(
          localKey: state.pageKey,
          pagelink: NutritionSummaryPage(
            foodsWithType: state.extra as List<Food>?,
            limitProtein: double.tryParse('${state.uri.queryParameters['limitProtein']}'),
            limitCarbohydrates: double.tryParse('${state.uri.queryParameters['limitCarbohydrates']}'),
            limitFat: double.tryParse('${state.uri.queryParameters['limitFat']}'),
          ),
          offset: const Offset(0, 1),
        ),
      ),
    ],
  );
}
