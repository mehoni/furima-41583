function price() {
  const priceInput = document.getElementById('item-price');
  const taxPriceElement = document.getElementById('add-tax-price');
  const profitElement = document.getElementById('profit');

  if (!priceInput) return;

  function updatePrice() {
    const price = parseFloat(priceInput.value);

    if (isNaN(price) || price < 300 || price > 9999999) {
      taxPriceElement && (taxPriceElement.textContent = '');
      profitElement && (profitElement.textContent = '');
      return;
    }

    const tax = Math.floor(price * 0.1);
    const profit = Math.floor(price - tax);

    taxPriceElement && (taxPriceElement.textContent = tax);
    profitElement && (profitElement.textContent = profit);
  }

  priceInput.addEventListener('input', updatePrice);
  updatePrice(); // ページロード時にも適用
}

// Turboのイベントをグローバルに登録
document.addEventListener("turbo:load", price);
document.addEventListener("turbo:render", price);
document.addEventListener("DOMContentLoaded", price);
