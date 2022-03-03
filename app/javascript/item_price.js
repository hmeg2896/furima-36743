window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
    priceInput.addEventListener("input", () =>{
      const inputValue = priceInput.value;
        
   
      const taxInput = document.getElementById("add-tax-price");
      const taxRate = 0.1;
      const taxInclude = inputValue * taxRate;
      taxInput.innerHTML = Math.floor(taxInclude);
        
      
      const profitInput = document.getElementById("profit");
      const profit = inputValue - taxInclude;
      profitInput.innerHTML = profit;
    }); 
  });
