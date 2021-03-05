String generateOrderKey({String store}){
  return '${DateTime.now().millisecondsSinceEpoch.toString()}_${store}';
}