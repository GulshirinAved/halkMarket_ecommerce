//fonts
import 'package:flutter/cupertino.dart';
import 'package:halkmarket_ecommerce/app_localization.dart';
import 'package:halkmarket_ecommerce/data/models/product_model.dart';

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
const String messageIcon = 'assets/icons/message.svg';
const String infoIcon = 'assets/icons/info.svg';
const String crownIcon = 'assets/icons/crown.svg';
const String globeIcon = 'assets/icons/globe.svg';
const String moonIcon = 'assets/icons/moon.svg';
const String eyeIcon = 'assets/icons/eye.svg';
const String eyeOffIcon = 'assets/icons/eyeOff.svg';
const String googleIcon = 'assets/icons/google.svg';
const String appleIcon = 'assets/icons/apple.svg';
const String trashIcon = 'assets/icons/trash.svg';
const String cuteHeartIcon = 'assets/icons/cuteHeart.svg';
const String cuteBoldHeartIcon = 'assets/icons/cuteBoldHeart.svg';
const String gpsIcon = 'assets/icons/gps.svg';
const String locateIcon = 'assets/icons/locate.svg';
const String pencilIcon = 'assets/icons/pencil.svg';

//images
const String bannerImage = 'assets/images/banner.png';
const String product1Image = 'assets/images/products/product1.png';
const String product2Image = 'assets/images/products/product2.png';
const String milkProductsImage = 'assets/images/products/milkProducts.png';
const String eggImage = 'assets/images/products/egg.png';
const String brandImage = 'assets/images/brands/brand.png';
const String halkMarketImage = 'assets/images/halkMarket.png';
const String sale1Image = 'assets/images/products/sale1.png';
const String sale2Image = 'assets/images/products/sale2.png';
const String cleaningImage = 'assets/images/products/oil.png';
const String foodImage = 'assets/images/products/food.png';
const String drinkImage = 'assets/images/products/drink.png';
const String sweetImage = 'assets/images/products/sweet.png';
const String cosmeticsImage = 'assets/images/products/cosmetics.png';
const String zooImage = 'assets/images/products/zoo.png';
const String new1Image = 'assets/images/products/new1.png';
const String new2Image = 'assets/images/products/new2.png';
const String foodProduct1Image = 'assets/images/products/foodProduct1.png';
const String foodProduct2Image = 'assets/images/products/foodProduct2.png';
const String cleaning1Image = 'assets/images/products/cleaning1.png';
const String cleaning2Image = 'assets/images/products/cleaning2.png';
const String cosmeticsProduct1Image =
    'assets/images/products/cosmeticsProduct1.png';
const String cosmeticsProduct2Image =
    'assets/images/products/cosmeticsProduct2.png';
const String milkProducts1Image = 'assets/images/products/milkProducts1.png';
const String milkProducts2Image = 'assets/images/products/milkProducts2.png';
const String zooProduct1Image = 'assets/images/products/zooProduct1.png';
const String zooProduct2Image = 'assets/images/products/zooProduct2.png';
const String milkCategoryImage = 'assets/images/products/milkCategory.png';
const String milkCategory2Image = 'assets/images/products/milkCategory2.png';
const String milkCategory3Image = 'assets/images/products/milkCategory3.png';
const String milkCategory4Image = 'assets/images/products/milkCategory4.png';
const String milkCategory5Image = 'assets/images/products/milkCategory5.png';
const String foodCategory1Image = 'assets/images/products/foodCategory1.png';
const String foodCategory2Image = 'assets/images/products/foodCategory2.png';
const String foodCategory3Image = 'assets/images/products/foodCategory3.png';
const String foodCategory4Image = 'assets/images/products/foodCategory4.png';
const String foodCategory5Image = 'assets/images/products/foodCategory5.png';
const String milkBrand1Image = 'assets/images/brands/milkBrand1.png';
const String milkBrand2Image = 'assets/images/brands/milkBrand2.png';
const String milkBrand3Image = 'assets/images/brands/milkBrand3.png';
const String meatBrand1Image = 'assets/images/brands/meatBrand1.png';
const String meatBrand2Image = 'assets/images/brands/meatBrand2.png';
const String meatBrand3Image = 'assets/images/brands/meatBrand3.png';
const String meatBrand4Image = 'assets/images/brands/meatBrand4.png';
const String meatBrand5Image = 'assets/images/brands/meatBrand5.png';
const String meatBrand6Image = 'assets/images/brands/meatBrand6.png';
const String meatBrand7Image = 'assets/images/brands/meatBrand7.png';
const String meatBrand8Image = 'assets/images/brands/meatBrand8.png';
const String meatBrand9Image = 'assets/images/brands/meatBrand9.png';
const String meatBrand10Image = 'assets/images/brands/meatBrand10.png';
const String meatBrand11Image = 'assets/images/brands/meatBrand11.png';
const String meatBrand12Image = 'assets/images/brands/meatBrand12.png';
const String meatBrand13Image = 'assets/images/brands/meatBrand13.png';
const String whiteBrand1Image = 'assets/images/brands/whiteBrand1.png';
const String whiteBrand2Image = 'assets/images/brands/whiteBrand2.png';
const String whiteBrand3Image = 'assets/images/brands/whiteBrand3.png';
const String whiteBrand4Image = 'assets/images/brands/whiteBrand4.png';
const String whiteBrand5Image = 'assets/images/brands/whiteBrand5.png';
const String whiteBrand6Image = 'assets/images/brands/whiteBrand6.png';
const String whiteBrand7Image = 'assets/images/brands/whiteBrand7.png';
const String whiteBrand8Image = 'assets/images/brands/whiteBrand8.png';
const String whiteBrand9Image = 'assets/images/brands/whiteBrand9.png';
const String whiteBrand10Image = 'assets/images/brands/whiteBrand10.png';
const String whiteBrand11Image = 'assets/images/brands/whiteBrand11.png';
const String whiteBrand12Image = 'assets/images/brands/whiteBrand12.png';
const String whiteBrand13Image = 'assets/images/brands/whiteBrand13.png';
const String whiteBrand14Image = 'assets/images/brands/whiteBrand14.png';
const String whiteBrand15Image = 'assets/images/brands/whiteBrand51.png';
const String whiteBrand16Image = 'assets/images/brands/whiteBrand16.png';
const String whiteBrand17Image = 'assets/images/brands/whiteBrand17.png';
const String whiteBrand18Image = 'assets/images/brands/whiteBrand18.png';

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

//small categories
final List<Map<String, dynamic>> smallCategories = [
  {'icon': saleIcon, 'title': 'Скидки и акции'},
  {'icon': newsIcon, 'title': 'Новинки сезона'},
  {'icon': fruitIcon, 'title': 'Фрукты и овощи'},
  {'icon': milkIcon, 'title': 'Молочные продукты'},
  {'icon': foodIcon, 'title': 'Продукты питания'},
  {'icon': waterIcon, 'title': 'Напитки'},
];
//homepage category products
final List<ProductModel> freshProducts = [
  ProductModel(
      id: '1',
      image: [product1Image],
      isNew: true,
      isSale: false,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
    id: '2',
    image: [product2Image],
    isNew: true,
    isSale: false,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
    withSugar: false,
  ),
  ProductModel(
    id: '3',
    image: [product2Image],
    isNew: true,
    isSale: false,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
  ),
  ProductModel(
      id: '4',
      image: [product2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '5',
      image: [product2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '6',
      image: [product2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '7',
      image: [product2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
];
//sale products
final List<ProductModel> saleProducts = [
  ProductModel(
      id: '1',
      image: [sale1Image],
      isNew: true,
      isSale: false,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: true),
  ProductModel(
    id: '2',
    image: [sale2Image],
    isNew: true,
    isSale: true,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
    withSugar: true,
  ),
  ProductModel(
    id: '3',
    image: [sale2Image],
    isNew: true,
    isSale: false,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
  ),
  ProductModel(
      id: '4',
      image: [sale2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '5',
      image: [sale2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '6',
      image: [sale2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '7',
      image: [sale2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
];
//new products
final List<ProductModel> newProducts = [
  ProductModel(
      id: '1',
      image: [new1Image],
      isNew: true,
      isSale: false,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: true),
  ProductModel(
    id: '2',
    image: [new2Image],
    isNew: true,
    isSale: true,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
    withSugar: true,
  ),
  ProductModel(
    id: '3',
    image: [new2Image],
    isNew: true,
    isSale: false,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
  ),
  ProductModel(
      id: '4',
      image: [new2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '5',
      image: [new2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '6',
      image: [new2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '7',
      image: [new2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
];
//food products
final List<ProductModel> foodProducts = [
  ProductModel(
      id: '1',
      image: [foodProduct1Image],
      isNew: true,
      isSale: false,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: true),
  ProductModel(
    id: '2',
    image: [foodProduct2Image],
    isNew: true,
    isSale: true,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
    withSugar: true,
  ),
  ProductModel(
    id: '3',
    image: [foodProduct2Image],
    isNew: true,
    isSale: false,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
  ),
  ProductModel(
      id: '4',
      image: [foodProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '5',
      image: [foodProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '6',
      image: [foodProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '7',
      image: [foodProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
];
//cleaning products
final List<ProductModel> cleaningProducts = [
  ProductModel(
      id: '1',
      image: [cleaning1Image],
      isNew: true,
      isSale: false,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: true),
  ProductModel(
    id: '2',
    image: [cleaning2Image],
    isNew: true,
    isSale: true,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
    withSugar: true,
  ),
  ProductModel(
    id: '3',
    image: [cleaning2Image],
    isNew: true,
    isSale: false,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
  ),
  ProductModel(
      id: '4',
      image: [cleaning2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '5',
      image: [cleaning2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '6',
      image: [cleaning2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '7',
      image: [cleaning2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
];

//cosmetics products
final List<ProductModel> cosmeticsProducts = [
  ProductModel(
      id: '1',
      image: [milkProducts1Image],
      isNew: true,
      isSale: false,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: true),
  ProductModel(
    id: '2',
    image: [milkProducts2Image],
    isNew: true,
    isSale: true,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
    withSugar: true,
  ),
  ProductModel(
    id: '3',
    image: [milkProducts2Image],
    isNew: true,
    isSale: false,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
  ),
  ProductModel(
      id: '4',
      image: [milkProducts2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '5',
      image: [milkProducts2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '6',
      image: [milkProducts2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '7',
      image: [milkProducts2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
];
//milk products
final List<ProductModel> milkProduct = [
  ProductModel(
      id: '1',
      image: [cosmeticsProduct1Image],
      isNew: true,
      isSale: false,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: true),
  ProductModel(
    id: '2',
    image: [cosmeticsProduct2Image],
    isNew: true,
    isSale: true,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
    withSugar: true,
  ),
  ProductModel(
    id: '3',
    image: [cosmeticsProduct2Image],
    isNew: true,
    isSale: false,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
  ),
  ProductModel(
      id: '4',
      image: [cosmeticsProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '5',
      image: [cosmeticsProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '6',
      image: [cosmeticsProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '7',
      image: [cosmeticsProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
];
//zoo products
final List<ProductModel> zooProducts = [
  ProductModel(
      id: '1',
      image: [zooProduct1Image],
      isNew: true,
      isSale: false,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: true),
  ProductModel(
    id: '2',
    image: [zooProduct2Image],
    isNew: true,
    isSale: true,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
    withSugar: true,
  ),
  ProductModel(
    id: '3',
    image: [zooProduct2Image],
    isNew: true,
    isSale: false,
    price: 14,
    prevPrice: '18.20',
    desc: 'Смесь для выпечки Печем дома "Оладьи"',
    weight: 250.0,
  ),
  ProductModel(
      id: '4',
      image: [zooProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '5',
      image: [zooProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '6',
      image: [zooProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
  ProductModel(
      id: '7',
      image: [zooProduct2Image],
      isNew: true,
      isSale: true,
      price: 14,
      prevPrice: '18.20',
      desc: 'Смесь для выпечки Печем дома "Оладьи"',
      weight: 250.0,
      withSugar: false),
];
//popular prodycts
final List<Map<String, dynamic>> popularProducts = [
  {'name': 'Молочная продукция', 'image': milkProductsImage},
  {'name': 'Уборка и гигиена', 'image': cleaningImage},
  {'name': 'Продукты питания', 'image': foodImage},
  {'name': 'Напитки', 'image': drinkImage},
  {'name': 'Конфеты', 'image': sweetImage},
  {'name': 'Косметика', 'image': cosmeticsImage},
  {'name': 'Зоотовары', 'image': zooImage},
];

final List<String> tipQuestion = [
  'Что есть разные средства с гармоничным составом',
  'Мне попадалась только косметика с натуральным составом',
  'Знаю лишь самое простое: шампунь, зубная паста',
  'Пару раз брал(а) патчи/маски/крем, но мало что про них знаю',
  'Беру только продукты, про косметику не знаю',
];
final List<Map<String, dynamic>> milkCategoryProducts = [
  {'name': 'Яйца', 'image': eggImage},
  {'name': 'Молоко, коктейль', 'image': milkCategoryImage},
  {'name': 'Сливки, кефир, творог', 'image': milkCategory2Image},
  {'name': 'Сыр', 'image': milkCategory3Image},
  {'name': 'Йогурт, айран', 'image': milkCategory4Image},
  {'name': 'Сгущённое молоко', 'image': milkCategory5Image},
];
final List<Map<String, dynamic>> foodCategoryProducts = [
  {'name': 'Торты', 'image': foodCategory1Image},
  {'name': 'Конфеты, мармелад', 'image': foodCategory2Image},
  {'name': 'Мука, кулинария', 'image': foodCategory3Image},
  {'name': 'Растительное масло', 'image': foodCategory4Image},
  {'name': 'Чипсы сухарики', 'image': foodCategory5Image},
  {'name': 'Кофе', 'image': milkCategory5Image},
];
final List<Map<String, dynamic>> cookingCategoryProducts = [
  {'name': 'Яйца', 'image': eggImage},
  {'name': 'Молоко, коктейль', 'image': milkCategoryImage},
  {'name': 'Сливки, кефир, творог', 'image': milkCategory2Image},
  {'name': 'Сыр', 'image': milkCategory3Image},
  {'name': 'Йогурт, айран', 'image': milkCategory4Image},
  {'name': 'Сгущённое молоко', 'image': milkCategory5Image},
];
final List<Map<String, dynamic>> breakfastCategoryProducts = [
  {'name': 'Яйца', 'image': eggImage},
  {'name': 'Молоко, коктейль', 'image': milkCategoryImage},
  {'name': 'Сливки, кефир, творог', 'image': milkCategory2Image},
  {'name': 'Сыр', 'image': milkCategory3Image},
  {'name': 'Йогурт, айран', 'image': milkCategory4Image},
  {'name': 'Сгущённое молоко', 'image': milkCategory5Image},
];

final List subCategories = [
  'Молоко',
  'Кефир',
  'Творог',
  'Сыр',
  'Йогурт',
  'Сметана и сливки',
];
final List<String> sortTitle = [
  'default',
  'popular',
  'news',
  'cheap',
  'expensive',
  'bigDiscount',
];
List<String> getPriceList(BuildContext context) {
  return [
    AppLocalization.of(context).getTransatedValues('toFiftyMan') ?? '',
    '50-200 ${AppLocalization.of(context).getTransatedValues('manat')}',
    '200 ${AppLocalization.of(context).getTransatedValues('manat')} ${AppLocalization.of(context).getTransatedValues('and')} ${AppLocalization.of(context).getTransatedValues('high')}',
    AppLocalization.of(context).getTransatedValues('notMatter') ?? '',
  ];
}

final List<String> categories = [
  'Фрукты и овощи',
  'Молочные продукты',
  'Продукты питания',
  'Напитки',
  'Правильное питание',
  'Продукты питания',
  'Напитки',
  'Правильное питание',
];
final List<String> brands = [
  'Kenar',
  'KHOSHBAKHT',
  'Özgeriş',
  'Buýsançly',
  'Emin Et',
  'Baltic mark',
  'Galkan',
  'Балтийский Невод',
];
final List<Map<String, dynamic>> milkBrands = [
  {'name': 'Gök önüm', 'image': brandImage},
  {'name': 'Gury iýmiş', 'image': milkBrand1Image},
  {'name': 'Bagdan', 'image': milkBrand2Image},
  {'name': 'Tudana', 'image': milkBrand3Image},
];
final List<Map<String, dynamic>> meatBrands = [
  {'name': 'Hindi towugy', 'image': meatBrand1Image},
  {'name': 'Kenar', 'image': meatBrand2Image},
  {'name': 'Emin Et', 'image': meatBrand3Image},
  {'name': 'KHOSHBAKHT', 'image': meatBrand4Image},
  {'name': 'Buýsançly', 'image': meatBrand5Image},
  {'name': 'За родину', 'image': meatBrand6Image},
  {'name': 'Köşüli', 'image': meatBrand6Image},
  {'name': 'Браславрыба', 'image': meatBrand7Image},
  {'name': 'Baltic mark', 'image': meatBrand8Image},
  {'name': 'Täze aý Şöhlat', 'image': meatBrand9Image},
  {'name': 'Özgeriş', 'image': meatBrand10Image},
  {'name': 'KHOSHBAKHT', 'image': meatBrand11Image},
  {'name': 'Galkan', 'image': meatBrand12Image},
  {'name': 'Балтийский Невод', 'image': meatBrand13Image},
];
final List<Map<String, dynamic>> milk2Brands = [
  {'name': 'Aýaz baba', 'image': whiteBrand1Image},
  {'name': 'Iner', 'image': whiteBrand2Image},
  {'name': 'Creamburg', 'image': whiteBrand3Image},
  {'name': 'Oltermanni', 'image': whiteBrand4Image},
  {'name': 'Erteki', 'image': whiteBrand5Image},
  {'name': 'Fruttis', 'image': whiteBrand6Image},
  {'name': 'Dag etek', 'image': whiteBrand6Image},
  {'name': 'Zamana', 'image': whiteBrand7Image},
  {'name': 'Valio', 'image': whiteBrand8Image},
  {'name': 'Damdaran', 'image': whiteBrand9Image},
  {'name': 'Ice cream', 'image': whiteBrand10Image},
  {'name': 'Нежный', 'image': whiteBrand11Image},
  {'name': 'Balgaýmak', 'image': whiteBrand12Image},
  {'name': 'Kalleh', 'image': whiteBrand13Image},
  {'name': 'Ramak', 'image': whiteBrand10Image},
  {'name': 'Нежный', 'image': whiteBrand11Image},
  {'name': 'Algida', 'image': whiteBrand12Image},
  {'name': 'Paýhas', 'image': whiteBrand13Image},
];
final List<Map<String, dynamic>> profileCard = [
  {'icon': messageIcon, 'title': 'support'},
  {'icon': infoIcon, 'title': 'helpAndInfo'},
  {'icon': crownIcon, 'title': 'aboutUs'},
];
final List<Map<String, dynamic>> profile2Card = [
  {'icon': globeIcon, 'title': 'lang'},
  {'icon': moonIcon, 'title': 'theme'},
];
final List<String> cartBill = [
  'cart',
  'productQuantity',
  'price',
  'delivery',
  'sale',
  'totalSum',
];
final List<String> langList = [
  'Türkmen',
  'Русский',
];
final List mapOptionIcons = [locateIcon, pencilIcon, searchIcon];
