class CarouselModel {
  String title;
  String image;
  String subtitle;
  CarouselModel(
      {required this.title, required this.image, required this.subtitle});
}

List<CarouselModel> carouselList = [
  CarouselModel(
      title: 'Medical Center',
      image: 'assets/images/doctor6.png',
      subtitle:
          'Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'),
  CarouselModel(
      title: 'Medical Center',
      image: 'assets/images/DOCTOR1.png',
      subtitle:
          'Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'),
  CarouselModel(
      title: 'Medical Center',
      image: 'assets/images/doctor4.png',
      subtitle:
          'Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'),
  CarouselModel(
      title: 'Medical Center',
      image: 'assets/images/dr.png',
      subtitle:
          'Yorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis.'),
];
