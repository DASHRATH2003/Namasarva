// This helps bridge the Dart-JS communication
function openRazorpay(options, successCallback, errorCallback) {
  var rzp = new Razorpay(options);
  rzp.open();
  rzp.on('payment.success', successCallback);
  rzp.on('payment.error', errorCallback);
}