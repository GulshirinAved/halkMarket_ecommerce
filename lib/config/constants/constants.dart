//fonts

import 'package:halkmarket_ecommerce/presentation/Screens/home/changePass_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/chat_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/feedback_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/myAddress_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/myOrders_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/payMethod_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/personalData_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/faq_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/support_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/home/trackOrder_screen.dart';
import 'package:halkmarket_ecommerce/presentation/Screens/webview/webview_screen.dart';

const String fontNunitoSans = 'NunitoSans';
const String fontExo2 = 'Exo2';

//icons
const String homeIcon = 'assets/icons/home.svg';
const String homeBoldIcon = 'assets/icons/homeBold.svg';
const String categoryIcon = 'assets/icons/category.svg';
const String categoryBoldIcon = 'assets/icons/categoryBold.svg';
const String cartIcon = 'assets/icons/cart.svg';
const String cartBoldIcon = 'assets/icons/cartBold.svg';
const String heartIcon = 'assets/icons/heart.svg';
const String heartBoldIcon = 'assets/icons/heartBold.svg';
const String userIcon = 'assets/icons/user.svg';
const String arrowRightIcon = 'assets/icons/arrowRight.svg';
const String locationIcon = 'assets/icons/location.svg';
const String searchIcon = 'assets/icons/search.svg';
const String saleIcon = 'assets/icons/sale.svg';
const String newsIcon = 'assets/icons/news.svg';
const String fruitIcon = 'assets/icons/fruit.svg';
const String milkIcon = 'assets/icons/milk.svg';
const String foodIcon = 'assets/icons/food.svg';
const String waterIcon = 'assets/icons/water.svg';
const String filterIcon = 'assets/icons/filter.svg';
const String infoIcon = 'assets/icons/info.svg';
const String crownIcon = 'assets/icons/crown.svg';
const String globeIcon = 'assets/icons/globe.svg';
const String moonIcon = 'assets/icons/moon.svg';
const String eyeIcon = 'assets/icons/eye.svg';
const String eyeOffIcon = 'assets/icons/eyeOff.svg';
const String trashIcon = 'assets/icons/trash.svg';
const String cuteHeartIcon = 'assets/icons/cuteHeart.svg';
const String cuteBoldHeartIcon = 'assets/icons/cuteBoldHeart.svg';
const String locateIcon = 'assets/icons/locate.svg';
const String pencilIcon = 'assets/icons/pencil.svg';
const String arrowUpIcon = 'assets/icons/arrowUp.svg';
const String arrowDownIcon = 'assets/icons/arrowDown.svg';
const String basketIcon = 'assets/icons/basket.svg';
const String truckIcon = 'assets/icons/truck.svg';
const String mapPinnedIcon = 'assets/icons/mapPinned.svg';
const String percentIcon = 'assets/icons/percent.svg';
const String userSquareIcon = 'assets/icons/userSquare.svg';
const String walletIcon = 'assets/icons/wallet.svg';
const String logoutIcon = 'assets/icons/logout.svg';
const String shareIcon = 'assets/icons/share.svg';
const String menuIcon = 'assets/icons/menu.svg';
const String rotateArrowIcon = 'assets/icons/rotateArrow.svg';
const String closeIcon = 'assets/icons/close.svg';
const String lockIcon = 'assets/icons/lock.svg';
const String groupMessageIcon = 'assets/icons/groupMessage.svg';
const String helpIcon = 'assets/icons/help.svg';
const String messageIcon = 'assets/icons/message.svg';
const String addCardIcon = 'assets/icons/addCard.svg';
const String cpuIcon = 'assets/icons/cpu.svg';
const String cardIcon = 'assets/icons/card.svg';
const String sendIcon = 'assets/icons/send.svg';
const String attachIcon = 'assets/icons/attach.svg';
const String plusIcon = 'assets/icons/plus.svg';
const String notepadIcon = 'assets/icons/notepad.svg';
const String shieldIcon = 'assets/icons/shield.svg';

//images

const String cardBg = 'assets/images/cardBg.png';
const String halkMarketImage = 'assets/images/halkMarket.png';

//animation
const String emptyAnimation = 'assets/animation/empty.json';
const String loadingAnimation = 'assets/animation/loading.json';
const String errorAnimation = 'assets/animation/error.json';
const String nowifiAnimation = 'assets/animation/nowifi.json';
List<Map<String, dynamic>> bottomNavBarItemName = [
  {
    'icon': homeIcon,
    'iconBold': homeBoldIcon,
  },
  {
    'icon': categoryIcon,
    'iconBold': categoryBoldIcon,
  },
  {
    'icon': cartIcon,
    'iconBold': cartBoldIcon,
  },
  {
    'icon': heartIcon,
    'iconBold': heartBoldIcon,
  },
];

final List<String> sortTitle = [
  'popular',
  'cheaper',
  'expensive',
  'recommended',
  'newproducts',
];

final List<Map<String, dynamic>> profileCard = [
  {
    'icon': infoIcon,
    'title': 'helpAndInfo',
    'screen': const SupportScreen(),
  },
  {
    'icon': crownIcon,
    'title': 'aboutUs',
    'screen': const WebViewScreen(
      topTitle: 'aboutUs',
      path: 'http://216.250.13.221:3000/about-us',
    ),
  },
  {
    'icon': groupMessageIcon,
    'title': 'feedback',
    'screen': const FeedbackScreen(),
  },
  {
    'icon': helpIcon,
    'title': 'faq',
    'screen': const FaqScreen(),
  },
  {
    'icon': messageIcon,
    'title': 'chat',
    'screen': const ChatScreen(),
  },
];
final List<Map<String, dynamic>> longProfileCard = [
  {
    'icon': basketIcon,
    'title': 'myOrders',
    'screen': const MyordersScreen(),
  },
  {
    'icon': truckIcon,
    'title': 'whereMyOrder',
    'screen': const TrackOrderScreen(),
  },
  {
    'icon': mapPinnedIcon,
    'title': 'myAddresses',
    'screen': const MyAddressScreen(),
  },
  {
    'icon': infoIcon,
    'title': 'helpAndInfo',
    'screen': const SupportScreen(),
  },
  {
    'icon': percentIcon,
    'title': 'bonusAndSale',
    'screen': const MyordersScreen(),
  },
  {
    'icon': crownIcon,
    'title': 'aboutUs',
    'screen': const WebViewScreen(
      topTitle: 'aboutUs',
      path: 'http://216.250.13.221:3000/about-us',
    ),
  },
  {
    'icon': groupMessageIcon,
    'title': 'feedback',
    'screen': const FeedbackScreen(),
  },
  {
    'icon': helpIcon,
    'title': 'faq',
    'screen': const FaqScreen(),
  },
  {
    'icon': messageIcon,
    'title': 'chat',
    'screen': const ChatScreen(),
  },
];
final List<Map<String, dynamic>> profile2Card = [
  {'icon': globeIcon, 'title': 'lang'},
];
final List<String> cartBill = [
  'productQuantity',
  'price',
  'delivery',
];
final List<String> langList = [
  'Türkmen',
  'Русский',
];

List<Map<String, dynamic>> settingsCards = [
  {
    'icon': userSquareIcon,
    'title': 'privateData',
    'screen': const PersonalDataScreen(),
  },
  {
    'icon': lockIcon,
    'title': 'changePass',
    'screen': const ChangepassScreen(),
  },
  {
    'icon': walletIcon,
    'title': 'payMethod',
    'screen': const PayMethodScreen(),
  },
];

final List conditionsForOrdering = [
  'orderCondition1',
  'orderCondition2',
  'orderCondition3',
  'orderCondition4',
  'orderCondition5',
];
final List addressEditOption = [
  {'icon': pencilIcon, 'title': 'edit'},
  {'icon': trashIcon, 'title': 'delete'},
];
final List<String> genderList = ['male', 'female'];
final List<String> timeList = ['today', 'tomorrow'];
final List<Map<String, dynamic>> clockList = [
  {'untilTo': '10:00', 'untilFrom': '12:00'},
  {'untilTo': '13:00', 'untilFrom': '15:00'},
  {'untilTo': '16:00', 'untilFrom': '18:00'},
  {'untilTo': '19:00', 'untilFrom': '21:00'},
];
final List<Map<String, dynamic>> helpList = [
  {
    'icon': walletIcon,
    'title': 'conditionsOrders',
    'path': 'http://216.250.13.221:3000/delivery-and-payment',
  },
  {
    'icon': notepadIcon,
    'title': 'usageRule',
    'path': 'http://216.250.13.221:3000/delivery-and-payment',
  },
  {
    'icon': shieldIcon,
    'title': 'privacy',
    'path': 'http://216.250.13.221:3000/delivery-and-payment',
  }
];
