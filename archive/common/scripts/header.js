  
  async function loadFragment(id, file) {
    const response = await fetch(file);
    const html = await response.text();
    document.getElementById(id).innerHTML = html;
    console.log(html);
  }

  loadFragment("header", "../../archive/common/header.html");


  