import 'package:google_mobile_ads/google_mobile_ads.dart';

class MobileAdsModel {
  //Get Banner Ad
  BannerAd getBannerAd(String unitId) {
    return BannerAd(
      adUnitId: unitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
          onAdLoaded: (Ad ad) => print('Ad loaded'),
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            ad.dispose();
            print('Ad Failed to load : $error');
          },
          onAdOpened: (Ad ad) => print('Ad opened.'),
          onAdClosed: (Ad ad) => print('Ad closed.'),
          onAdImpression: (Ad ad) => print('Ad impression')),
    );
  }

  //Get RewardedAd

  loadInterstitialVideo(String unitId) {
    InterstitialAd.load(
        adUnitId: unitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            // Keep a reference to the ad so you can show it later.
            ad.show();
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error');
          },
        ));
  }
}
