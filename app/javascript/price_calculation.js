function priceCalc() {
  const priceInput = document.getElementById('item-price');
  if (!priceInput) return;

  const addTaxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  priceInput.addEventListener('input', () => {
    const value = parseInt(priceInput.value);
    if (!isNaN(value) && value >= 300 && value <= 9999999) {
      const tax = Math.floor(value * 0.1);
      const gain = Math.floor(value - tax);

      addTaxPrice.textContent = tax.toLocaleString();
      profit.textContent = gain.toLocaleString();
    } else {
      addTaxPrice.textContent = '';
      profit.textContent = '';
    }
  });
}

document.addEventListener('turbo:load', priceCalc);
document.addEventListener('turbo:render', priceCalc);

