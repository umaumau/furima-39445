window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");
  priceInput.addEventListener("input", () => {
    const price = priceInput.value;
    addTaxPrice.innerHTML = `${Math.floor(price * 0.1)}`
    profit.innerHTML = `${price - Math.floor(price * 0.1)}`
  });
});