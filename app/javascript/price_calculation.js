// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails" //
import "controllers"

document.addEventListener('DOMContentLoaded', function() {
  const priceInput = document.getElementById('item-price'); // 価格入力フィールド
  const taxPriceElement = document.getElementById('add-tax-price'); // 販売手数料
  const profitElement = document.getElementById('profit'); // 販売利益

  // 価格計算を実行する関数
  function price() {
    const price = parseFloat(priceInput.value); // 入力された価格

    if (!isNaN(price) && price >= 300 && price <= 9999999) {
      const tax = price * 0.1; // 販売手数料（10%）
      const profit = price - tax; // 販売利益

      // Math.floorを使って小数点以下を切り捨てる
      taxPriceElement.textContent = Math.floor(tax); // 小数点以下を切り捨て
      profitElement.textContent = Math.floor(profit); // 小数点以下を切り捨て
    } else {
      // 入力価格が範囲外の場合、手数料と利益は非表示にする
      taxPriceElement.textContent = '';
      profitElement.textContent = '';
    }
  }

  priceInput.addEventListener('input', price); // 価格入力時に価格計算を実行

  window.addEventListener("turbo:load", price);
  window.addEventListener("turbo:render", price);
});
