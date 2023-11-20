class OnBoardModel {
  final String title;
  final String image;
  final String counterText;

  OnBoardModel(
      {required this.title, required this.image, required this.counterText});
}
 List<OnBoardModel> onBoardList = [
  OnBoardModel(title:'Health checks & consultations easily anywhere anytime',
     image: 'assets/images/splash2.png', counterText:'Next'),
  OnBoardModel(title: 'Thousands of doctors & experts to help your health!',
     image: 'assets/images/splash1.png', counterText:'Next'),
  OnBoardModel(title:"Let's start living healthy and well with us right now",
     image: 'assets/images/splash3.png',counterText: 'Get Started'),
];