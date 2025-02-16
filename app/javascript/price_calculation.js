document.addEventListener('DOMContentLoaded', function() {
  const priceInput = document.getElementById('item-price');
  const taxPriceElement = document.getElementById('add-tax-price');
  const profitElement = document.getElementById('profit');

  // priceInput が存在する場合にのみ処理を実行
  if (priceInput) {
    // 価格計算を実行する関数
    function price() {
      const price = parseFloat(priceInput.value);

      if (!isNaN(price) && price >= 300 && price <= 9999999) {
        const tax = Math.floor(price * 0.1);  // 販売手数料
        const profit = Math.floor(price - tax); // 販売利益

        if (taxPriceElement) taxPriceElement.textContent = tax;  // 手数料
        if (profitElement) profitElement.textContent = profit;  // 利益
      } else {
        if (taxPriceElement) taxPriceElement.textContent = '';  // 範囲外の場合
        if (profitElement) profitElement.textContent = '';  // 範囲外の場合
      }
    }

    priceInput.addEventListener('input', price); // 価格入力時に価格計算を実行

    // Turboでページ遷移時にも再計算
    window.addEventListener("turbo:load", price);
    window.addEventListener("turbo:render", price);
  }
});
