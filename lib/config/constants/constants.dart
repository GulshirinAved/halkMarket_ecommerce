//fonts
const String fontNunitoSans = 'assets/fonts/NunitoSans.ttf';

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

//images
const String bannerImage = 'assets/images/banner.png';
const String product1Image = 'assets/images/products/product1.png';
const String product2Image = 'assets/images/products/product2.png';
const String milkProductsImage = 'assets/images/products/milkProducts.png';
const String eggImage = 'assets/images/products/egg.png';
const String brandImage = 'assets/images/brand.png';

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
    'icon': heartIcon,
    'iconBold': heartBoldIcon,
  },
  {
    'icon': cartIcon,
    'iconBold': cartBoldIcon,
  },
];

//small categories
final List<Map<String, dynamic>> smallCategories = [
  {'icon': saleIcon, 'title': 'Скидки и акции'},
  {'icon': newsIcon, 'title': 'Новинки сезона'},
  {'icon': fruitIcon, 'title': 'Фрукты и овощи'},
  {'icon': milkIcon, 'title': 'Молочные продукты'},
  {'icon': foodIcon, 'title': 'Продукты питания'},
  {'icon': waterIcon, 'title': 'Напитки'},
];

final List<Map<String, dynamic>> newProducts = [
  {
    'image': product1Image,
    'isNew': true,
    'isSale': false,
    'price': '14.20',
    'prevPrice': '18.20',
    'desc': 'Смесь для выпечки Печем дома "Оладьи"',
    'weight': '250',
  },
  {
    'image': product2Image,
    'isNew': true,
    'isSale': true,
    'price': '14.20',
    'prevPrice': '18.20',
    'desc': 'Смесь для выпечки Печем дома "Оладьи"',
    'weight': '250',
  }
];
final List<String> tipQuestion = [
  'Что есть разные средства с гармоничным составом',
  'Мне попадалась только косметика с натуральным составом',
  'Знаю лишь самое простое: шампунь, зубная паста',
  'Пару раз брал(а) патчи/маски/крем, но мало что про них знаю',
  'Беру только продукты, про косметику не знаю',
];
final List<String> milkProducts = [
  'Яйца',
  'Сливки, кефир, творог',
  'Молоко, коктейль',
  'Сыр',
  'Сливки, кефир, творог',
  'Йогурт, айран',
  'Сгущённое молоко',
];
