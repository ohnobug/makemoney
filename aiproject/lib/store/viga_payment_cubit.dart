import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// 定義支付流程中的所有可枚舉狀態
enum VigaPaymentMethod { alipay, huabei }
enum VigaPaymentStatus { initial, selecting, confirming, enteringPassword, verifying, success, failed }

// State: 儲存支付流程的所有數據
class VigaPaymentState extends Equatable {
  final double paymentAmount;
  final String merchantName;
  final VigaPaymentMethod selectedMethod;
  final VigaPaymentStatus status;
  final String? errorMessage;

  const VigaPaymentState({
    this.paymentAmount = 24.80, // 默認示例金額
    this.merchantName = '信息科技旗舰店', // 默認示例商家
    this.selectedMethod = VigaPaymentMethod.alipay,
    this.status = VigaPaymentStatus.initial,
    this.errorMessage,
  });

  // copyWith 方法用於創建一個新的狀態實例，同時更新指定的字段
  VigaPaymentState copyWith({
    double? paymentAmount,
    String? merchantName,
    VigaPaymentMethod? selectedMethod,
    VigaPaymentStatus? status,
    String? errorMessage,
  }) {
    return VigaPaymentState(
      paymentAmount: paymentAmount ?? this.paymentAmount,
      merchantName: merchantName ?? this.merchantName,
      selectedMethod: selectedMethod ?? this.selectedMethod,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [paymentAmount, merchantName, selectedMethod, status, errorMessage];
}

// Cubit: 管理業務邏輯
class VigaPaymentCubit extends Cubit<VigaPaymentState> {
  VigaPaymentCubit() : super(const VigaPaymentState());

  // 1. 開始支付流程
  void startPaymentFlow() {
    // 這裡可以傳入金額和商家名稱等參數
    emit(state.copyWith(status: VigaPaymentStatus.selecting));
  }

  // 2. 選擇支付方式
  void selectMethod(VigaPaymentMethod method) {
    emit(state.copyWith(selectedMethod: method));
  }

  // 3. 進入確認頁面
  void moveToConfirm() {
      emit(state.copyWith(status: VigaPaymentStatus.confirming));
  }

  // 4. 準備輸入密碼
  void moveToPasswordEntry() {
      emit(state.copyWith(status: VigaPaymentStatus.enteringPassword));
  }

  // 5. 驗證密碼 (異步操作)
  Future<void> verifyPassword(String password) async {
    emit(state.copyWith(status: VigaPaymentStatus.verifying));
    // 模擬 1.5 秒的網路請求延遲
    await Future.delayed(const Duration(milliseconds: 1500));

    if (password == "123456") { // 假設 '123456' 是正確密碼
      emit(state.copyWith(status: VigaPaymentStatus.success));
    } else {
      emit(state.copyWith(status: VigaPaymentStatus.failed, errorMessage: "密碼錯誤，請重試"));
      // 失敗後，可以選擇重置回輸入密碼狀態
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: VigaPaymentStatus.enteringPassword));
    }
  }

  // 6. 重置支付狀態
  void resetPayment() {
    emit(const VigaPaymentState());
  }

  // 7. 更新支付金額
  void updatePaymentAmount(double amount) {
    emit(state.copyWith(paymentAmount: amount));
  }

  // 8. 更新商家名稱
  void updateMerchantName(String name) {
    emit(state.copyWith(merchantName: name));
  }
}